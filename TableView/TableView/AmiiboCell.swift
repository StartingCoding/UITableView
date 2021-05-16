//
//  AmiiboCell.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import UIKit

class AmiiboCell: UITableViewCell {
    let imageIV = UIImageView()
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupView() {
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
    }
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIV.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageIV.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageIV.widthAnchor.constraint(equalToConstant: 40),
            imageIV.heightAnchor.constraint(equalToConstant: 40)
        ])
        imageIV.backgroundColor = .red
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
    }
    
    func setupGameSeriesLabel() {
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}
