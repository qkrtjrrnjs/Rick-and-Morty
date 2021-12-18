//
//  Location.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation

struct LocationURL: Decodable {
    var url: String
}

struct Location: Decodable {
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
}
