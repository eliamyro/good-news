//
//  GoodNewsRepoMock.swift
//  GoodNewsTests
//
//  Created by Elias Myronidis on 17/12/23.
//

import Combine
import Foundation
@testable import GoodNews

class GoodNewsRepoMock: GoodNewsRepo {
    public let stub = Stub()

    public init() {}

    public class Stub {
        @Unwrapable public var getTopHeadlines: (() -> AnyPublisher<APIArticlesResponse, RequestError>)?
    }

    func getTopHeadlines(for country: String) -> AnyPublisher<APIArticlesResponse, RequestError> {
        return stub.$getTopHeadlines.safeValue()()
    }
}
