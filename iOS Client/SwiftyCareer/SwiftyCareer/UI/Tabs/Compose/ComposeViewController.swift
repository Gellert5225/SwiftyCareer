//
//  ComposeViewController.swift
//  ComposeViewController
//
//  Created by Gellert Li on 8/22/21.
//

import UIKit
import WebKit
import Foundation

typealias OldClosureType = @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Any?) -> Void
typealias NewClosureType = @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void

class CustomWebView: WKWebView, ComposeAccessoryViewDelegate, WKScriptMessageHandler {
    
    var accessoryView: ComposeAccessoryView?
    
    let selectionHandler = "selectionHandler"
    
    private var _keyboardDisplayRequiresUseraction = true

    var keyboardDisplayRequiresUserAction: Bool? {
        get {
            return _keyboardDisplayRequiresUseraction
        }
        set {
            _keyboardDisplayRequiresUseraction = newValue ?? true
            self.setKeyboardRequiresUserInteraciton(_keyboardDisplayRequiresUseraction)
        }
    }

    private func setKeyboardRequiresUserInteraciton(_ value: Bool) {
        guard let WKContentViewClass: AnyClass = NSClassFromString("WKContentView") else {
            return print("Cannot find WKContentView class")
        }

        let oldSelector: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:")
        let newSelector: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:changingActivityState:userObject:")

        if let method = class_getInstanceMethod(WKContentViewClass, oldSelector) {
            let originalImp: IMP = method_getImplementation(method)
            let original: OldClosureType = unsafeBitCast(originalImp, to: OldClosureType.self)
            let block: @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3) in
                original(me, oldSelector, arg0, !value, arg2, arg3)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }
        if let method = class_getInstanceMethod(WKContentViewClass, newSelector) {
            let originalImp: IMP = method_getImplementation(method)
            let original: NewClosureType = unsafeBitCast(originalImp, to: NewClosureType.self)
            let block: @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3, arg4) in
                original(me, newSelector, arg0, !value, arg2, arg3, arg4)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }
    }
    
    override var inputAccessoryView: UIView? {
        if (accessoryView == nil) {
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
    
    // MARK: ComposeAccessoryViewDelegate
    func orderedList() {
        
    }
    
    func bulletList() {
        
    }
    
    func format(_ format: String, sender: UIImageView) {
        self.evaluateJavaScript("get\(format)Status()", completionHandler: { (result, error) in
            DispatchQueue.main.async {
                if let formatted = result as? Int {
                    sender.image = (formatted == 0) ? UIImage(named: "\(format)Selected") : UIImage(named: format)
                    sender.setNeedsDisplay()

                } else { // selected text is not bold
                    sender.image = UIImage(named: "\(format)Selected")
                }
                sender.setNeedsDisplay()
                self.evaluateJavaScript("format\(format)()")
            }
        })
    }
    
    // MARK: WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == selectionHandler {
            if let body = message.body as? Dictionary<String, Any> {
                print(body)
                if (body["bold"] as! Int == 1) {
                    accessoryView!.boldView.image = UIImage(named: "BoldSelected")
                } else {
                    accessoryView!.boldView.image = UIImage(named: "Bold")
                }
                
                if (body["italic"] as! Int == 1) {
                    accessoryView!.italicView.image = UIImage(named: "ItalicSelected")
                } else {
                    accessoryView!.italicView.image = UIImage(named: "Italic")
                }
                
                if (body["underline"] as! Int == 1) {
                    accessoryView!.underlineView.image = UIImage(named: "UnderlineSelected")
                } else {
                    accessoryView!.underlineView.image = UIImage(named: "Underline")
                }
            }
        }
    }
}

class ComposeViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var composeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var composeView: CustomWebView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowFunction(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                
        composeView.keyboardDisplayRequiresUserAction = false
        
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
            "head.appendChild(meta);" +
            "quill.focus();"
        
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        composeView.configuration.userContentController.addUserScript(script)
    }
    
    @objc func closeComposeView() {
        dismiss(animated: true, completion: nil)
    }

    @objc func keyboardWillShowFunction(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.composeViewHeight.constant =  self.view.frame.height - keyboardSize - 50 - self.navigationController!.navigationBar.frame.height
        self.composeView.layoutIfNeeded()
    }
}
