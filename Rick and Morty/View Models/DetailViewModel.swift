//
//  DetailViewModel.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation
import UIKit

class DetailViewModel {
    private let apiService: APIService
    var location: Observable<Location> = Observable(Location(name: "", type: "", dimension: "", residents: []))
    var errorMessage: Observable<String> = Observable("")
    var image: Observable<UIImage> = Observable(UIImage())
    var id: String = ""
    var imageURL: String = ""
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchData() {
        Task {
            do {
                let location: Location = try await apiService.fetchData(for: RMEndpoint.locations(id: id))
                self.location.value = location
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func fetchImage() {
        Task {
            do {
                if let cachedImage = CacheManager.shared.get(urlString: imageURL) {
                    self.image.value = cachedImage
                    return
                }
                guard let url = URL(string: imageURL) else {
                    errorMessage.value = "Invalid image URL!"
                    return
                }

                let image: UIImage = try await apiService.fetchImage(for: RMEndpoint.avatar(component: url.lastPathComponent))
                self.image.value = image
                CacheManager.shared.add(urlString: imageURL, image: image)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
}
