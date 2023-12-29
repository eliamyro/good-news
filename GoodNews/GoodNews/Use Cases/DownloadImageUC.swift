//
//  DownloadImageUC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 28/12/23.
//

import Combine
import UIKit

protocol DownloadImageUC {
    func execute(imageUrl: String) -> AnyPublisher<UIImage?, Never>
}

class DownloadImageUCImp: DownloadImageUC {
    @Injected var repo: GoodNewsRepo

    func execute(imageUrl: String) -> AnyPublisher<UIImage?, Never> {
        repo.downloadImage(imageUrl: imageUrl)
    }
}
