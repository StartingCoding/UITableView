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
        
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        guard let amiiboCell = cell as? AmiiboCell else {
            return cell
        }
        
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        if let url = URL(string: amiibo.image) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AmiiboListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            self.amiiboList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
