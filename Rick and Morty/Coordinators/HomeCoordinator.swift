//
//  HomeCoordinator.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel(apiService: RMAPIService()))
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func moveToDetailViewController(id: String, imageURL: String) {
        let viewModel = DetailViewModel(apiService: RMAPIService())
        viewModel.id = id
        viewModel.imageURL = imageURL
        let detailViewController = DetailViewController(viewModel: viewModel)
        detailViewController.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
