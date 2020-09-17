//
//  ViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    func setUpView() {
        self.view.backgroundColor = UIColor.background_color
        createAccountButton.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        let vc: RegisterViewController = segue.destination as! RegisterViewController
        if segue.identifier == "RegisterSeg" {
            vc.registerType = .register
        } else if segue.identifier == "LoginSeg" {
            vc.registerType = .login
        }
    }
}

