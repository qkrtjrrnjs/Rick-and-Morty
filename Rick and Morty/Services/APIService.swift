//
//  APIService.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation
import UIKit

enum APIError: LocalizedError {
    case invalidURL
    case failedToInitializeImage

    var errorDescription: String?{
        switch self {
        case .invalidURL:
            return "Invalid URL!"
        case .failedToInitializeImage:
            return "Failed to initialize image from data!"
        }
    }
}

protocol APIService {
    func fetchData<T: Decodable>(for endPoint: Endpoint) async throws -> T
    func fetchImage(for endpoint: Endpoint) async throws -> UIImage
}

class RMAPIService: APIService {
    func fetchData<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let results = try JSONDecoder().decode(T.self, from: data)

        return results
    }
    
    func fetchImage(for endpoint: Endpoint) async throws -> UIImage {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw APIError.failedToInitializeImage
        }
        
        return image
    }
}
