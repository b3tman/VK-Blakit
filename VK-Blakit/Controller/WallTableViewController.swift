//
//  WallTableViewController.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 02.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class WallTableViewController: UITableViewController {

    let wallCellIdentifier = "wallCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    //MARK: - Private
    private func registerCell() {
        let nib = UINib(nibName: "WallTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: wallCellIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: wallCellIdentifier, for: indexPath) as? WallTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel?.text = "Maxim Brishten"
        
        return cell
    }
    

}
