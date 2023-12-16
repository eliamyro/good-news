//
//  TabBarItem.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import UIKit

enum TabBarItem {
    case topHeadlines
    case search
    case favorites

    var title: String {
        switch self {
        case .topHeadlines:
            return "Top Headlines"
        case .search:
            return "Search"
        case .favorites:
            return "Favorites"
        }
    }

    var icon: String {
        switch self {
        case .topHeadlines:
            return "list.star"
        case .search:
            return "magnifyingglass"
        case .favorites:
            return "star.fill"
        }
    }

    var controller: UIViewController {
        switch self {
        case .topHeadlines:
            return TopHeadlinesVC(viewModel: TopHeadlinesVM())
        case .search:
            return ViewController()
        case .favorites:
            return ViewController()
        }
    }

    var tag: Int {
        switch self {
        case .topHeadlines:
            return 0
        case .search:
            return 1
        case .favorites:
            return 2
        }
    }
}
