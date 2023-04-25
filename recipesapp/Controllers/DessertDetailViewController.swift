//
//  DessertDetailViewController.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import UIKit

/// Controller to house details for specific meal
final class DessertDetailViewController: UIViewController {

    
    // MARK: - Properties
    
    private let viewModel: RAMealDetailViewViewModel
    
    private let detailView = RAMealDetailView()

    init(viewModel: RAMealDetailViewViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported ")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        layoutView()
        detailView.configure(with: viewModel)
        
    }
    
    private func setupView() {
        
        
        title = viewModel.mealTitle
        self.view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                                     detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                                     detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
    }
    

}
