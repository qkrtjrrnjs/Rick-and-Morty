//
//  Endpoint.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}

enum RMEndpoint: Endpoint {
    case characters(page: Int)
    case locations(id: String)
    case avatar(component: String)
    
    var baseURL: String {
        switch self {
        default:
            return "https://rickandmortyapi.com/api"
        }
    }
    
    var path: String {
        switch self {
        case .characters(let page):
            return "/character/?page=\(page)"
        case .locations(let id):
            return "/location/\(id)"
        case .avatar(let component):
            return "/character/avatar/\(component)"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
