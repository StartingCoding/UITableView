//
//  AmiiboListVC.swift
//  TableView
//
//  Created by Loris on 13/05/21.
//

import UIKit

class AmiiboListVC: UIViewController {
    let tableView = UITableView()
    var amiiboList = [Amiibo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        
        let anonymousFunction = { (amiiboFetched: [Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = amiiboFetched
                self.tableView.reloadData()
            }
        }
        
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymousFunction)
    }
    
    // MARK: - Setup
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        
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
        let amiibo = amiiboList[indexPath.row]
        cell.textLabel?.text = amiibo.name
        return cell
    }
}
