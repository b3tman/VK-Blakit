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
    
    func presentAlertController(_ title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { [unowned alertController] _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Date {
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.component(.hour, from: date)
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.component(.minute, from: date)
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.component(.second, from: date)
    }
    
    func offset(from date: Date) -> String {
        let ago = "назад"
        let dateFormat = "d MMM"
        let yesterdayAt = "Вчера в "
        let timeString = "\(hours(from: date)):\(minutes(from: date))"
        
        let daysAgo = days(from: date)
        if daysAgo >= 2 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            dateFormatter.locale = Locale(identifier: "ru")
            let dateString = dateFormatter.string(from: date)
            return "\(dateString) в \(timeString)"
        }
        
        if daysAgo < 2, daysAgo >= 1 {
            return yesterdayAt + "\(timeString)"
        }
        
        let hoursAgo = hours(from: date)
        if hoursAgo > 0 {
            return "\(hoursAgo) \(WordEndPicker.getCorrectEnding(with: hoursAgo, and: DeclinedWord.hour)) \(ago)"
        }
        
        let minutesAgo = minutes(from: date)
        if minutesAgo > 0 {
            return "\(minutesAgo) \(WordEndPicker.getCorrectEnding(with: minutesAgo, and: DeclinedWord.minute)) \(ago)"
        }
        
        let secondsAgo = seconds(from: date)
        if secondsAgo > 0 {
            return "\(secondsAgo) \(WordEndPicker.getCorrectEnding(with: secondsAgo, and: DeclinedWord.second)) \(ago)"
        }
        
        return ""
    }
}

extension UIImageView {
    
    func setDefault() {
        self.image = nil
        self.backgroundColor = .darkGray
        self.isHidden = true
    }
    
    func roundCorners() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "Undefined error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                UIView.transition(with: self,
                              duration: 0.3,
                               options: .transitionCrossDissolve,
                            animations: {
                            self.image = UIImage(data: data!)
                },
                            completion: nil)
            })
        }).resume()
    }
}
