//
//  Character.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation

struct Characters: Decodable {
    var characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct Character: Decodable {
    var name: String
    var status: String
    var species: String
    var locationURL: LocationURL
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case status = "status"
        case species = "species"
        case locationURL = "location"
        case imageURL = "image"
    }
}


