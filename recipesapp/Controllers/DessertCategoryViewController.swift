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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: -  Methods
    private func setupUI() {
        
        // Navigation Bar
        self.title = "Desserts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.largeTitleDisplayMode = .always
        
        // Background
        self.view.backgroundColor = .systemBackground

    }
    
    

}
