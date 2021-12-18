//
//  DetailViewController.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import SnapKit
import UIKit

class DetailViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    private let viewModel: DetailViewModel
    
    let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpObservables()
        viewModel.fetchData()
        viewModel.fetchImage()
    }
    
    private func setUpObservables() {
        viewModel.image.bind { [weak self] image in
            DispatchQueue.main.async {
                self?.detailView.imageView.image = image
            }
        }
        
        viewModel.location.bind { [weak self] location in
            DispatchQueue.main.async {
                self?.detailView.location = location
            }
        }
    }
}
