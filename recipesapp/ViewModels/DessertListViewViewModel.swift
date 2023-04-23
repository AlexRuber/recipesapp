//
//  DessertListViewViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/19/23.
//

import Foundation
import UIKit

/// We want to follow SOLID Principles and have single responsibilities

/// The view model for the Dessert List View - all business logic for this view will live here
final class DessertListViewViewModel: NSObject  {
    func fetchDesserts() {
        let request = RARequest(endpoint: .dessert)
        
        RAService.shared.execute(request, expecting: RAMealsAPIResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: \(model.meals.first?.strMealThumb ?? "no image")")
                //print("Model: \(model)")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension DessertListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RADessertCollectionViewCell.cellIdentifier, for: indexPath) as? RADessertCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = RADessertCollectionViewCellViewModel(dessertName: "Tiramisu", dessertImageUrl: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
        cell.configure(with: viewModel)
        //cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        
        return CGSize(width: width, height: width*1.5)
    }
    
}
