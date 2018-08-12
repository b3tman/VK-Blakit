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

    //MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar?
    
    //MARK: - Properties
    private let networkManager = NetworkManager()
    private var groups = [Int: Group]()
    private var news = [News]()
    private var profiles = [Int: Profile]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        searchBar?.delegate = self
        registerCell()
        checkSession()
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
    
    //MARK: - Private
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
    
    private func registerCell() {
        let nib = UINib(nibName: "WallTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: wallCellIdentifier)
    }
    
    private func restoreData() {
        news = []
        groups = [:]
        profiles = [:]
    }
    
    private func getSourceNews(from sourceID: Int) -> Source? {
        if sourceID > 0 {
            return profiles[sourceID]
        } else {
            return groups[sourceID]
        }
    }
    
    private func loadNews(with searchNumber: Int) {
        networkManager.executeRequest(for: searchNumber) { [weak self] (answer, error) in
            guard let answerNews = answer?.news,
                let answerGroups = answer?.groups,
                let answerProfiles = answer?.profiles else { return }
            self?.news = answerNews
            self?.groups = answerGroups
            self?.profiles = answerProfiles
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: wallCellIdentifier, for: indexPath) as? WallTableViewCell else { return UITableViewCell() }
        
        let news = self.news[indexPath.row]
        let newsSourceID = news.sourceID
        
        if let source = getSourceNews(from: newsSourceID) {
            cell.prepare(with: news, with: source)
            cell.profileImageView?.image = nil
            cell.photoImageView?.setDefault()
            cell.profileImageView?.imageFromServerURL(urlString: source.photoURL)
            if let newsPostIcon = news.postIcon {
                cell.photoImageView?.imageFromServerURL(urlString: newsPostIcon)
                cell.photoImageView?.isHidden = false
            }
        }
        
        return cell
    }
}

extension WallTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else { return }
        if let number = Int(text) {
            self.searchBar?.endEditing(true)
            loadNews(with: number)
        } else {
            presentAlertController("Ошибка", message: "Вы ввели неправильный ID пользователя или группы")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            restoreData()
            tableView.reloadData()
        }
    }
}
