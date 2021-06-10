//
//  AmiiboDetailVC.swift
//  TableView
//
//  Created by Loris on 10/06/21.
//

import UIKit

class AmiiboDetailVC: UIViewController {
    var amiibo: AmiiboForView?
    
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupImage()
        setupName()
        setupDismissButton()
        setupData()
    }
    
    func setupImage() {
        view.addSubview(imageIV)
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageIV.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            imageIV.heightAnchor.constraint(equalTo: imageIV.widthAnchor)
        ])
    }
    
    func setupName() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageIV.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    func setupData() {
        if let amiibo = amiibo,
           let url = URL(string: amiibo.imageUrl) {
            imageIV.loadImage(from: url)
            nameLabel.text = amiibo.name
        }
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true)
    }
}
