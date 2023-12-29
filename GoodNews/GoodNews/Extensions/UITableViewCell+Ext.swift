//
//  UITableViewCell+Ext.swift
//  GoodNews
//
//  Created by Elias Myronidis on 18/12/23.
//

import UIKit

extension UITableViewCell {

    static var cellIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
