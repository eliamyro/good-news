//
//  NewsTag.swift
//  GoodNews
//
//  Created by Elias Myronidis on 28/12/23.
//

import Foundation

struct NewsTag: Hashable {
    let title: String
    var isSelected: Bool

    static var categories: [NewsTag] {
        return [NewsTag(title: "All", isSelected: true),
                    NewsTag(title: "Business", isSelected: false),
                    NewsTag(title: "Entertainment", isSelected: false),
                    NewsTag(title: "General", isSelected: false),
                    NewsTag(title: "Health", isSelected: false),
                    NewsTag(title: "Science", isSelected: false),
                    NewsTag(title: "Sports", isSelected: false),
                    NewsTag(title: "Technology", isSelected: false)]
    }
}
