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
    @IBOutlet var profileIcon: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var postTextLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
