//
//  UIColor+Ext.swift
//  GoodNews
//
//  Created by Elias Myronidis on 29/12/23.
//

import UIKit

enum AssetsColor: String {
    case denim
    case dimGray
    case lavenderBlue
    case raven
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

