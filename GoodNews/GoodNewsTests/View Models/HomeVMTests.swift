//
//  HomeVMTests.swift
//  GoodNewsTests
//
//  Created by Elias Myronidis on 28/12/23.
//

import Combine
import XCTest
@testable import GoodNews

final class HomeVMTests: XCTestCase {
    var cancellables: AnyCancellable?

    private func arrange() -> (vm: HomeVM,
                               getTopHeadlinesUCMock: GetTopHeadlinesUCMock) {
        let getTopHeadlinesUCMock = GetTopHeadlinesUCMock()

        DInjection.shared = DInjection(empty: true)
            .register(GetTopHeadlinesUC.self) { getTopHeadlinesUCMock }

        return (HomeVM(), getTopHeadlinesUCMock)
    }

    func testGetTopHeadlines() {
        let r = arrange()

        r.getTopHeadlinesUCMock.stub.execute = { Just(APIArticlesResponse.fakeAPIArticlesResponse)
                .setFailureType(to: RequestError.self)
                .eraseToAnyPublisher()
        }

        let expectation = expectation(description: "Fetch top headlines")
        r.vm.getTopHeadlines()

        cancellables = r.vm.$apiArticles.sink { articles in
            if articles == APIArticlesResponse.fakeAPIArticlesResponse.articles {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2)
    }
}
