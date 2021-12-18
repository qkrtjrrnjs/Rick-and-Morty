//
//  HomeViewController.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: HomeCoordinator?
    private let viewModel: HomeViewModel
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .white
        setUpTableView()
        setUpObservables()
        viewModel.fetchData()
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }
    
    private func setUpObservables() {
        viewModel.characters.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorMessage.bind { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(with: errorMessage)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        cell?.character = viewModel.characters.value[indexPath.row]
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = URL(string: viewModel.characters.value[indexPath.row].locationURL.url)?.lastPathComponent ?? ""
        let imageURL = viewModel.characters.value[indexPath.row].imageURL
        coordinator?.moveToDetailViewController(id: id, imageURL: imageURL)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - scrollView.frame.size.height {
            if !viewModel.isPaginating {
                viewModel.fetchData()
            }
        }
    }
}
