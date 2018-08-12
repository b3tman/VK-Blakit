//
//  LoginViewController.swift
//  VK-Blakit
//
//  Created by Максим Бриштен on 02.08.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sdk = VKSdk.initialize(withAppId: appID) {
            sdk.register(self)
            sdk.uiDelegate = self
        }
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: UIButton) {
        VKSdk.wakeUpSession(scope) { (_ state: VKAuthorizationState, _ error: Error?) -> Void in
            switch state {
            case .authorized:
                self.performSegue(withIdentifier: wallSegue, sender: nil)
                break
            case .initialized:
                VKSdk.authorize(scope)
                break
            case .error:
                self.presentAlertController("Ошибка авторизации", message: "Проверьте интернет подключение. Попробуйте еще раз.")
                break
            default:
                break
            }
        }
    }
    
    //MARK: - VK_ios_sdk delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        UserDefaults.standard.set(true, forKey: authorizedKey)
        
        let wallController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: wallControllerIdentifier)
        UIApplication.shared.delegate?.window??.rootViewController = wallController
    }
    
    func vkSdkUserAuthorizationFailed() {
        self.presentAlertController("Что-то пошло не так", message: "Не удаось авторизовать вас на сервере")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
