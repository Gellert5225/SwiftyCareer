//
//  RegisterViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import SCWebAPI

enum RegisterType {
    case register
    case login
}

class RegisterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var fieldTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var registerType: RegisterType?
    var field: UITextField?
    
    var placeholders: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let theTextField = self.view.viewWithTag(1) as? UITextField {
            theTextField.becomeFirstResponder()
        }
    }
    
    func setUpView() {
        if registerType == .register {
            titleLabel.text = "Create Your Account"
            placeholders = ["Username", "Email", "Password", "Confirm Password"]
        } else {
            titleLabel.text = "Login to SwiftyCareer"
            placeholders = ["Username", "Password"]
        }
        
        fieldTableView.delegate = self
        fieldTableView.dataSource = self
        fieldTableView.tableFooterView = UIView()
        fieldTableView.separatorColor = UIColor.light_gray
        fieldTableView.tag = 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerType == .register ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height < 812 ? 50 : 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath)
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        field = UITextField(frame: CGRect(x: 0, y: 4, width: fieldTableView.frame.width, height: UIScreen.main.bounds.height < 812 ? 45 : 65))
        field!.delegate = self
        field!.autocorrectionType = .no
        field!.font = UIFont(name: "SF UI Text Regular", size: 18)
        field!.attributedPlaceholder = NSAttributedString(string: placeholders[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.light_gray])
        field!.autocapitalizationType = .none
        field!.textColor = UIColor.white
        
        if ((registerType == .register && indexPath.row == 3) ||
            (registerType == .login && indexPath.row == 1)) {
            field!.returnKeyType = .go
            field!.isSecureTextEntry = true
        } else {
            field!.returnKeyType = .next
            field!.isSecureTextEntry = false
        }
        
        if (registerType == .register && indexPath.row == 2) {
            field!.isSecureTextEntry = true
        }
        
        cell.addSubview(field!)
        field!.tag = indexPath.row + 1
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
            print("next")
        } else {
            textField.resignFirstResponder()
            print("resign")
                        
            let usernameField = textField.superview?.superview?.viewWithTag(1) as! UITextField
            let username = usernameField.text!
            
            if registerType == .login {
                let pwField = textField.superview?.superview?.viewWithTag(2) as! UITextField
                let password = pwField.text!
                
                let signin = SCResource(path: "/api/rest/auth/signin", method: .POST, params: ["username": username, "password": password])
                SCXHR().request(resource: signin) { response in
                    if let error = response.err {
                        self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK", defaultButtonAction: {}), animated: true, completion: nil)
                    }
                    if let res = response.res {
                        if let error = response.err {
                            self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK", defaultButtonAction: {}), animated: true, completion: nil)
                        } else {
                            UserDefaults.standard.set(response.cookie![0].value, forKey: response.cookie![0].name)
                            if let userJSON = res["info"] as? JSON {
                                UserDefaults.standard.set(jsonToString(json: userJSON), forKey: "currentUser")
                            }
                            
                            self.present(prepareDrawerMenu(), animated:true, completion: nil)
                        }
                    }
                }

            } else {
                let emailField = textField.superview?.superview?.viewWithTag(2) as! UITextField
                
                let pwField = textField.superview?.superview?.viewWithTag(3) as! UITextField
                
                //let confirmField = textField.superview?.superview?.viewWithTag(3) as! UITextView
                
                let signup = SCResource(path: "/api/rest/auth/signup", method: .POST, params: ["username": username, "password": pwField.text!, "email": emailField.text!])
                
                SCXHR().request(resource: signup) { response in
                    if let error = response.err {
                        self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK", defaultButtonAction: {}), animated: true, completion: nil)
                    }
                    if let res = response.res {
                        if let error = response.err {
                            self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK", defaultButtonAction: {}), animated: true, completion: nil)
                        } else {
                            UserDefaults.standard.set(response.cookie![0].value, forKey: response.cookie![0].name)
                            if let userJSON = res["info"] as? JSON {
                                print(userJSON)
                                UserDefaults.standard.set(jsonToString(json: userJSON), forKey: "currentUser")
                            }
                            self.present(prepareDrawerMenu(), animated:true, completion: nil)
                        }
                    }
                }
            }
            
        }

        return true
    }

}
