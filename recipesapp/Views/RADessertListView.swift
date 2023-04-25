//
//  RADessertListView.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/19/23.
//

import UIKit

protocol RADessertListViewDelegate: AnyObject {
    func raDessertListView(_ dessertListView: RADessertListView, didSelectMeal: RAMealModel)
}

/// View that displays Dessert list view, loader, etc.
final class RADessertListView: UIView {
   
    //MARK: - Properties
    private let viewModel = DessertListViewViewModel()
    
    public weak var delegate: RADessertListViewDelegate?

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RADessertCollectionViewCell.self, forCellWithReuseIdentifier: RADessertCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        layoutUI()
        viewModel.delegate = self
        viewModel.fetchDesserts()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupUI() {
        self.addSubview(spinner)
        self.addSubview(collectionView)
        spinner.startAnimating()
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: topAnchor),
             collectionView.leftAnchor.constraint(equalTo: leftAnchor),
             collectionView.rightAnchor.constraint(equalTo: rightAnchor),
             collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel

    }
    
}

/// RADessertListViewViewModelDelegate delegate methods
extension RADessertListView: RADessertListViewViewModelDelegate {
    func didSelectMeal(_ meal: RAMealModel) {
        delegate?.raDessertListView(self, didSelectMeal: meal)
    }
    
    func didLoadInitialMeals() {
        
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1.0
        }
        
    }
}
