//
//  GetTopHeadlinesUCMock.swift
//  GoodNewsTests
//
//  Created by Elias Myronidis on 28/12/23.
//

import Combine
import Foundation
@testable import GoodNews

class GetTopHeadlinesUCMock: GetTopHeadlinesUC {
    public let stub = Stub()

    public init() {}

    public class Stub {
        @Unwrapable public var execute: (() -> AnyPublisher<APIArticlesResponse, RequestError>)?
    }

    func execute(country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError> {
        return stub.$execute.safeValue()()
    }
}
