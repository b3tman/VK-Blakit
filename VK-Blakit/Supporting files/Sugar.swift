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

extension Date {
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func offset(from date: Date) -> String {
        let ago = "назад"
        let dateFormat = "d MMM"
        let yesterdayAt = "Вчера в"
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


