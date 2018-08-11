//
//  WallTableViewController.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 02.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SwiftyJSON

class WallTableViewController: UITableViewController {

    let wallCellIdentifier = "wallCellIdentifier"
    private let networkManager = NetworkManager()
    private var groups = [Int : Group]()
    private var news = [News]()
    private var profiles = [Int : Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        registerCell()
        checkSession()
        loadNews()
    }
    
    //MARK: - Actions
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        let cancel = "Отмена"
        let exit = "Выход"
        
        let confirmAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        let exitAction = UIAlertAction(title: exit, style: .destructive) { (action) in
            self.logOut()
        }
        confirmAlert.addAction(cancelAction)
        confirmAlert.addAction(exitAction)
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func logOut() {
        if let storyboard = self.storyboard {
            VKSdk.forceLogout()
            UserDefaults.standard.set(false, forKey: authorizedKey)
            
            let loginController = storyboard.instantiateViewController(withIdentifier: loginControllerIdentifier)
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    private func checkSession() {
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .initialized {
                self.logOut()
            }
        }
    }
    
    private func loadNews() {
        networkManager.executeRequest(for: 89497074) { [weak self] (answer, error) in
            guard let answerNews = answer?.news,
                  let answerGroups = answer?.groups,
                  let answerProfiles = answer?.profiles else { return }
            self?.news = answerNews
            self?.groups = answerGroups
            self?.profiles = answerProfiles
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Private
    private func registerCell() {
        let nib = UINib(nibName: "WallTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: wallCellIdentifier)
    }
    
    private func getSourceNews(from sourceID: Int) -> Source? {
        if sourceID > 0 {
            return profiles[sourceID]
        } else {
            return groups[sourceID]
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: wallCellIdentifier, for: indexPath) as? WallTableViewCell else { return UITableViewCell() }
        
        let news = self.news[indexPath.row]
        let newsSourceID = news.sourceID
        
        if let source = getSourceNews(from: newsSourceID) {
            cell.prepareCell(with: news, with: source)
        }
        
        return cell
    }
}
