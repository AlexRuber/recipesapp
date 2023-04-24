//
//  DessertListViewViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/19/23.
//

import Foundation
import UIKit

protocol RADessertListViewViewModelDelegate: AnyObject {
    func didLoadInitialMeals()
    func didSelectMeal(_ meal: RAMealModel)
}

/// We want to follow SOLID Principles and have single responsibilities

/// The view model for the Dessert List View - all business logic for this view will live here
final class DessertListViewViewModel: NSObject  {
    
    // MARK: - Properties
    
    public weak var delegate: RADessertListViewViewModelDelegate?
    
    private var meals: [RAMealModel] = [] {
        didSet {
            for meal in meals {
                let vM = RADessertCollectionViewCellViewModel(dessertName: meal.strMeal, dessertImageUrl: URL(string: meal.strMealThumb), mealId: meal.idMeal)
                cellViewModels.append(vM)
            }
        }
    }
    private var cellViewModels: [RADessertCollectionViewCellViewModel] = []
    
    /// Fetch initial set of meals (20)
    func fetchDesserts() {
        let request = RARequest(endpoint: .dessert)
        
        RAService.shared.execute(request, expecting: RAMealsAPIResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let meals = responseModel.meals
                self?.meals = meals
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialMeals()
                }
                // Refresh the data in the collection view
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional meals are needed when user scrolls to bottom
    public func fetchAdditionalMeals() {
        
    }
    
    public var shouldShowLoadMoreIndiciator: Bool {
        return false
    }
}

// MARK: - CollectionView Protocol Methods

extension DessertListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RADessertCollectionViewCell.cellIdentifier, for: indexPath) as? RADessertCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        //cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let meal = meals[indexPath.row]
        delegate?.didSelectMeal(meal)
    }
    
}
