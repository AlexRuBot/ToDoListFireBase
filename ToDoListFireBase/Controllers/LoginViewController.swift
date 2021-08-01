//
//  ViewController.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 30.07.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginSegue = "LoginSegue"

    @IBOutlet weak var warnLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        warnLable.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.loginSegue)!, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    // анимация появления ошибки при авторизации
    func displayWarningLable (whithText text: String) {
        warnLable.text = text
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {[weak self] in self?.warnLable.alpha = 1})
                        {[weak self] complete in self?.warnLable.alpha = 0}
    }
    
    // MARK: - Авторизация
    @IBAction func loginTap(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLable(whithText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.displayWarningLable(whithText: "Error authentication")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: (self?.loginSegue)!, sender: nil)
                return
            }
            self?.displayWarningLable(whithText: "No such user")
        }
    }
    
    // MARK: - Регистрация
    @IBAction func registerTap(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLable(whithText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if error == nil {
                if user != nil {
                    self?.performSegue(withIdentifier: (self?.loginSegue)!, sender: nil)
                }
            }
        }
        
    }
    
    
    // MARK: - Настройка сдвига экрана при открытии клавиатуры
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.size.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                          left: 0,
                                                                          bottom: kbFrameSize.height,
                                                                          right: 0)
    }

    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.size.height)
    }
}

