//
//  GetTopHeadlinesUCTests.swift
//  GoodNewsTests
//
//  Created by Elias Myronidis on 17/12/23.
//

import Combine
import XCTest
@testable import GoodNews

final class GetTopHeadlinesUCTests: XCTestCase {

    private func arrange() -> (uc: GetTopHeadlinesUC, repoMock: GoodNewsRepoMock) {
        let repoMock = GoodNewsRepoMock()

        DInjection.shared = DInjection(empty: true)
            .register(GoodNewsRepo.self) { repoMock }

        return (GetTopHeadlinesUCImp(), repoMock)
    }

    func testGetTopHeadlinesSuccess() {
        let r = arrange()

        r.repoMock.stub.getTopHeadlines = {
            Just(APIArticlesResponse.fakeAPIArticlesResponse)
                .setFailureType(to: RequestError.self)
                .eraseToAnyPublisher()
        }

        let actualResult = r.uc.execute(country: "gr", category: "Health")

        waitForValue(of: actualResult, value: APIArticlesResponse.fakeAPIArticlesResponse)
    }

    func testGetTopHeadlinesFailed() {
        let r = arrange()

        let exp = expectation(description: "Fails")

        r.repoMock.stub.getTopHeadlines = {
            Fail(error: RequestError.invalidResponse).eraseToAnyPublisher()
        }

        _ = r.uc.execute(country: "gr", category: "Health").sink { completion in
            guard case .failure(let error) = completion else { return }
            XCTAssertEqual(error, RequestError.invalidResponse)
            exp.fulfill()
        } receiveValue: { _ in
            XCTFail("Expected to fail")
        }

        waitForExpectations(timeout: 2)
    }
}
