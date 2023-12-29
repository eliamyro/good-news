//
//  TabBarItem.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import UIKit

enum TabBarItem {
    case home
    case search
    case favorites

    var tabTitle: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .favorites:
            return "Favorites"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .favorites:
            return "star.fill"
        }
    }

    var controller: UIViewController {
        switch self {
        case .home:
            return HomeVC(viewModel: HomeVM())
        case .search:
            return ViewController()
        case .favorites:
            return ViewController()
        }
    }

    var tag: Int {
        switch self {
        case .home:
            return 0
        case .search:
            return 1
        case .favorites:
            return 2
        }
    }
}
