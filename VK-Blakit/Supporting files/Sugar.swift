//
//  Sugar.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 03.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with title: String?, message: String?) {
        let okay = "Хорошо"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okay, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

