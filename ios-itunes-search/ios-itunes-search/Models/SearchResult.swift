//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by patelpra on 3/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String?
    var creator: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
