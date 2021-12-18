//
//  HomeViewModel.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation

class HomeViewModel {
    private let apiService: APIService
    var characters: Observable<[Character]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var isPaginating = false
    var page = 1

    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchData() {
        Task {
            do {
                if !isPaginating { isPaginating = true }
                let result: Characters = try await apiService.fetchData(for: RMEndpoint.characters(page: page))
                characters.value.append(contentsOf: result.characters)
                isPaginating = false
                page += 1
            } catch {
                errorMessage.value = error.localizedDescription
                isPaginating = false
            }
        }
    }
}
