//
//  DInjection.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

class DIInitializer {
    static func setup() {
        DInjection.shared = DInjection()
    }
}

class DInjection: DependencyContainer {
    static var shared = DependencyContainer()

    init(empty: Bool = false) {
        super.init()

        if !empty { registerDependencies() }
    }

    private func registerDependencies() {
        registerSources()
        registerRepositories()
        registerUseCases()
    }

    private func registerSources() {
        register(HTTPClient.self) { HTTPClientImp() }
    }

    private func registerRepositories() {
        register(GoodNewsRepo.self) { GoodNewsRepoImp() }
    }

    private func registerUseCases() {
        register(GetTopHeadlinesUC.self) { GetTopHeadlinesUCImp() }
    }
}
