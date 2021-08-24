//
//  ComposeViewController.swift
//  ComposeViewController
//
//  Created by Gellert Li on 8/22/21.
//

import UIKit
import WebKit

class CustomWebView: WKWebView, ComposeAccessoryViewDelegate, WKScriptMessageHandler {
    
    var accessoryView: ComposeAccessoryView?
    
    let selectionHandler = "selectionHandler"
    
    override var inputAccessoryView: UIView? {
        if (accessoryView == nil) {
            print("called")
            accessoryView = Bundle.main.loadNibNamed("ComposeAccessoryView", owner: self, options: nil)?.first as? ComposeAccessoryView
            accessoryView!.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
            accessoryView!.delegate = self
            return accessoryView
        }
        
        return accessoryView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: selectionHandler)
        self.configuration.userContentController.add(self, name: selectionHandler)
    }
    
    func bold() {
        self.evaluateJavaScript("getBoldStatus()", completionHandler: { (result, error) in
            DispatchQueue.main.async {
                if let bold = result as? Int {
                    print(bold)
                    self.accessoryView!.label.text = "HA"
                    self.accessoryView!.boldView.image = (bold == 0) ? UIImage(named: "BoldSelected") : UIImage(named: "Bold")
                    self.accessoryView!.boldView.setNeedsDisplay()

                } else { // selected text is not bold
                    self.accessoryView!.boldView.image = UIImage(named: "Bold")
                }
                self.accessoryView!.boldView.setNeedsDisplay()
                self.evaluateJavaScript("formatBold()")
            }
        })
    }
    
    func italic() {
        
    }
    
    func orderedList() {
        
    }
    
    func bulletList() {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == selectionHandler {
//            if let  {
//
//            }
        }
    }
}

class ComposeViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var composeView: CustomWebView!
    
    @IBOutlet weak var label: UILabel!
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

}
