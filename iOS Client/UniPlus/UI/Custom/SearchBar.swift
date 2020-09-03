//
//  SearchBar.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//
import SwiftUI

struct SearchNavigation<Content: View>: UIViewControllerRepresentable {
    @Binding var text: String
    var tapped: () -> Void
    var search: () -> Void
    var cancel: () -> Void
    var content: () -> Content

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
        navigationController.navigationBar.prefersLargeTitles = false
        
        context.coordinator.searchController.searchBar.delegate = context.coordinator
        context.coordinator.searchController.definesPresentationContext = true
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.update(content: content())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(content: content(), searchText: $text, tapAction: tapped, searchAction: search, cancelAction: cancel)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        let rootViewController: UIHostingController<Content>
        let searchController = UISearchController(searchResultsController: nil)
        var tapped: () -> Void
        var search: () -> Void
        var cancel: () -> Void
        
        init(content: Content, searchText: Binding<String>, tapAction: @escaping () -> Void, searchAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
            rootViewController = UIHostingController(rootView: content)
            let searchBarContainer = SearchBarContainerView(customSearchBar: searchController.searchBar)
            searchBarContainer.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
            
            searchController.searchBar.autocapitalizationType = .none
            searchController.obscuresBackgroundDuringPresentation = true
            //searchController.searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.definesPresentationContext = true
            
            rootViewController.navigationItem.titleView = searchBarContainer
            
            if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField,
                let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
                    textFieldInsideSearchBar.layer.cornerRadius = 15
                    textFieldInsideSearchBar.layer.masksToBounds = true
                    //Magnifying glass
                    glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                    glassIconView.tintColor = LIGHT_GRAY
            }
            
            _text = searchText
            
            tapped = tapAction
            search = searchAction
            cancel = cancelAction
        }
        
        func update(content: Content) {
            rootViewController.rootView = content
            rootViewController.view.setNeedsDisplay()
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            tapped()
            return true
        }

        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            cancel()
            return true
        }
        
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("text did change")
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            search()
        }
        
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("cancel")
            cancel()
        }
    }
    
}

class SearchBarContainerView: UIView {

    let searchBar: UISearchBar

    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)

        addSubview(searchBar)
    }

    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
