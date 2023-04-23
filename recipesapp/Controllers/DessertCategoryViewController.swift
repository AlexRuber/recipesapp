//
//  DessertCategoryViewController.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import UIKit

/// Controller to show all dessert meal options 
class DessertCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dessertListView = RADessertListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupNavigationBar() {
        // Navigation Bar
        self.title = "Desserts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupMealListView() {
        view.addSubview(dessertListView)
        NSLayoutConstraint.activate([dessertListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     dessertListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                                     dessertListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                                     dessertListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    
    // MARK: -  Methods
    private func setupUI() {
        // Navigation Bar
        setupNavigationBar()
        
        // Dessert List View
        setupMealListView()
        
        // Background
        self.view.backgroundColor = .systemBackground
        
    }
    
    

}
