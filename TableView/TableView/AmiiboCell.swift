//
//  AmiiboCell.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import UIKit

class AmiiboCell: UITableViewCell {
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    let owningCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupView() {
        setupOwningCountingLabel()
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
    }
    
    func setupOwningCountingLabel() {
        addSubview(owningCountLabel)
        
        owningCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            owningCountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            owningCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupImageView() {
        addSubview(imageIV)
        imageIV.contentMode = .scaleAspectFit
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIV.leadingAnchor.constraint(equalTo: owningCountLabel.trailingAnchor, constant: 5),
            imageIV.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageIV.widthAnchor.constraint(equalToConstant: 40),
            imageIV.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
        
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupGameSeriesLabel() {
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
        gameSeriesLabel.font = UIFont(name: "Verdana", size: 14)
    }
}
