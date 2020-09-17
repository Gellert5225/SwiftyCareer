//
//  RegisterViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import Parse

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
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath)
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        field = UITextField(frame: CGRect(x: 0, y: 4, width: fieldTableView.frame.width, height: 65))
        field!.delegate = self
        field!.autocorrectionType = .no
        field!.font = UIFont(name: "SF UI Text Regular", size: 18)
        field!.attributedPlaceholder = NSAttributedString(string: placeholders[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.light_gray])
        
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
                
                PFUser.logInWithUsername(inBackground: username, password: password) {
                  (user: PFUser?, error: Error?) -> Void in
                  if user != nil {
                    self.present(prepareDrawerMenu(), animated:true, completion: nil)
                  } else {
                    print(error?.localizedDescription ?? "Unkown Error")
                  }
                }
            } else {
                let emailField = textField.superview?.superview?.viewWithTag(2) as! UITextField
                
                let pwField = textField.superview?.superview?.viewWithTag(3) as! UITextField
                
                //let confirmField = textField.superview?.superview?.viewWithTag(3) as! UITextView
                
                let user = PFUser()
                user.username = username
                user.password = pwField.text!
                user.email = emailField.text!
                
                user.signUpInBackground { (succeeded: Bool, error: Error?) -> Void in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.present(prepareDrawerMenu(), animated:true, completion: nil)
                    }
                }
            }
            
        }

        return true
    }

}
