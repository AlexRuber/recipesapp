//
//  RAMealDetailViewViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import Foundation

protocol RAMealDetailsViewViewModelDelegate: AnyObject {
    func didLoadMealDetails(meal: RAMealsDetailsAPIResponse)
}

/// The view model for the Meal Detail View
final class RAMealDetailViewViewModel {
    
    private var meal: RAMealModel?
    
    public weak var delegate: RAMealDetailsViewViewModelDelegate?
    
    init(meal: RAMealModel?) {
        self.meal = meal
    }
    
    public var mealTitle: String {
        return meal?.strMeal ?? "Dessert"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let mealString = meal?.strMealThumb, let url = URL(string: mealString)  else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    /// Fetch meal details for a specific meal
    public func fetchMealDetails() {
        guard let mealId = meal?.idMeal else { return }
        let queryParam = [URLQueryItem(name: "i", value: mealId)]

        let request = RARequest(endpoint: .mealDetails, queryParameters: queryParam)

        RAService.shared.execute(request, expecting: RAMealsDetailsAPIResponse.self) { [weak self] result in
            print(result)
            switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    print("The meal details are: \(mealDetails)")
                    self?.delegate?.didLoadMealDetails(meal: mealDetails)
                }
                // Refresh the data in the collection view
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    

    
}
