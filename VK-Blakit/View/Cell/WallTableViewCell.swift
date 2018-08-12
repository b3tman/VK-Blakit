//
//  WallTableViewCell.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 02.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class WallTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet var profileImageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var postTextView: UITextView?
    @IBOutlet var photoImageView: UIImageView?
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView?.roundCorners()
    }
    
    //MARK: - Methods
    func prepare(with news: News, with source: Source) {
        self.nameLabel?.text = source.name
        self.dateLabel?.text = Date().offset(from: news.date)
        self.postTextView?.text = news.text
    }
}
