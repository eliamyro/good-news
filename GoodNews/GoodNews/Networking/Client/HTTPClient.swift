//
//  HTTPClient.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import UIKit

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, RequestError>
    func downloadImage(endpoint: Endpoint) -> AnyPublisher<UIImage?, Never>
}

class HTTPClientImp: HTTPClient {
    let cacheManager = CacheManager.shared

    func sendRequest<T>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, RequestError> where T: Decodable {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        guard let url = urlComponents.url else {
            print("Failed to get url from urlComponents")
            return Fail(error: RequestError.invalidURL).eraseToAnyPublisher()
        }

        print("URL: \(url)")

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header // Try also without it

        return URLSession.shared.dataTaskPublisher(for: request)
            .assumeHTTP()
            .responseData()
            .decoding(T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func downloadImage(endpoint: Endpoint) -> AnyPublisher<UIImage?, Never> {
        let cacheKey = NSString(string: endpoint.path)

        if let image = cacheManager.object(for: cacheKey) {
            return Just(image).eraseToAnyPublisher()
        }

        guard let url = URL(string: endpoint.path) else {
            print("Failed to get url from urlComponents")
            return Just(nil).eraseToAnyPublisher()
        }

        print("URL: \(url)")

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { [weak self] data, response in
                guard let self = self, let gResponse = response as? HTTPURLResponse,
                      gResponse.statusCode >= 200 && gResponse.statusCode < 300,
                      let image = UIImage(data: data) else {
                    return nil
                }

                self.cacheManager.addToCache(image, for: cacheKey)
                return image
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
