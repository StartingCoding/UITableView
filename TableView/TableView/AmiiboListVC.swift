//
//  AmiiboListVC.swift
//  TableView
//
//  Created by Loris on 13/05/21.
//

import UIKit

class AmiiboListVC: UIViewController {
    let tableView = UITableView()
    
    let amiiboList = ["Zelda", "Link", "Navi", "Ganondorf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - Setup View
    func setupView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension AmiiboListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let name = amiiboList[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
}
