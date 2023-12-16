//
//  ViewController.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import UIKit

class ViewController: UIViewController {

    @Injected var dummyUC: DummyUC

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        print(APIKey.shared.apiKey)

        print(dummyUC.execute())
    }
}
