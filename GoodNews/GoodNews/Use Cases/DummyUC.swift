//
//  DummyUC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

protocol DummyUC {
    func execute() -> String
}

class DummyUCImp: DummyUC {
    func execute() -> String {
        return "Successful"
    }
}
