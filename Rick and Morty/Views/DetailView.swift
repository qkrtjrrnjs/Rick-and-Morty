//
//  DetailView.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import SnapKit
import UIKit

class DetailView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let numOfResidentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var location: Location? {
        didSet {
            if let location = location {
                nameLabel.text = location.name
                typeLabel.text = location.type
                dimensionLabel.text = location.dimension
                numOfResidentsLabel.text = "\(location.residents.count) residents"
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(typeLabel)
        addSubview(dimensionLabel)
        addSubview(numOfResidentsLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(UIScreen.main.bounds.height / 2.5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
        }
        
        dimensionLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
        }
        
        numOfResidentsLabel.snp.makeConstraints { make in
            make.top.equalTo(dimensionLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
        }
    }
}
