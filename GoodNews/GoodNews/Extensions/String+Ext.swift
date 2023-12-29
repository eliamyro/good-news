//
//  String+Ext.swift
//  GoodNews
//
//  Created by Elias Myronidis on 29/12/23.
//

import Foundation

extension String {
    var formatedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: self) ?? Date()

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd MMM, yyyy"
        return newFormatter.string(from: date)
    }
}
