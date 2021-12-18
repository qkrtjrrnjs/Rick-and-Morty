//
//  HomeTableViewCell.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import SnapKit
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCellId"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var character: Character? {
        didSet {
            if let character = character {
                nameLabel.text = character.name
                statusLabel.text = character.status
                speciesLabel.text = character.species
                changeTextColor(for: character.status)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLabels() {
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(speciesLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(statusLabel.snp.top).offset(-15)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(speciesLabel.snp.top).offset(-15)
        }
        
        speciesLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(snp.bottom).offset(-15)
        }
    }
    
    private func changeTextColor(for status: String) {
        if status == "Alive" {
            statusLabel.textColor = .systemGreen
        } else if status == "Dead" {
            statusLabel.textColor = .systemRed
        } else if status == "unknown" {
            statusLabel.textColor = .systemGray
        }
    }
}
