//
//  ComposeViewController.swift
//  ComposeViewController
//
//  Created by Gellert Li on 8/22/21.
//

import UIKit
import WebKit

class CustomWebView: WKWebView {
    var accessoryView: UIView?
    override var inputAccessoryView: UIView? {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        bar.items = [reset]
        bar.sizeToFit()
        return bar
    }
    
    @objc func resetTapped() {
        print("tapped")
    }
}

class ComposeViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var composeView: CustomWebView!
    @IBOutlet weak var boldButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        self.navigationItem.title = "Create a post"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.addTarget(self, action: #selector(closeComposeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)

        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
        let url = Bundle.main.url(forResource: "compose", withExtension: "html")!
        composeView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
             
        composeView.navigationDelegate = self
        composeView.load(request)
        
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"

        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        composeView.configuration.userContentController.addUserScript(script)
    }
    
    @objc func closeComposeView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func formatBold(_ sender: UIButton) {
        composeView.evaluateJavaScript("formatBold()", completionHandler: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
