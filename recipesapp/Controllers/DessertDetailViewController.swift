//
//  DessertDetailViewController.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import UIKit

/// Controller to house details for specific meal
final class DessertDetailViewController: UIViewController {
    
    private let viewModel: RAMealDetailViewViewModel

    init(viewModel: RAMealDetailViewViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported ")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.mealTitle
        self.view.backgroundColor = .systemBackground
    }
    

}
