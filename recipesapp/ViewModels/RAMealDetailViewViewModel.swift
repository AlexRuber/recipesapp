//
//  RAMealDetailViewViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import Foundation

protocol RADessertDetailsViewViewModelDelegate: AnyObject {
    func didLoadMealDetails(meal: RAMealsDetailsAPIResponse)
}

final class RAMealDetailViewViewModel {
    
    private var meal: RAMealDetailsModel
    
    public weak var delegate: RADessertDetailsViewViewModelDelegate?
    
    init(meal: RAMealDetailsModel) {
        self.meal = meal
    }
    
    public var mealTitle: String {
        guard let mealTitle = meal.strMeal else { return "Dessert "}
        return mealTitle
    }
    
    /// Fetch initial set of meals
    func fetchMealDetails(mealId: String) {
        let queryParam = [URLQueryItem(name: "i", value: mealId)]
        let request = RARequest(endpoint: .mealDetails, queryParameters: queryParam)
        
        RAService.shared.execute(request, expecting: RAMealsDetailsAPIResponse.self) { [weak self] result in
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self?.delegate?.didLoadMealDetails(meal: meal)
                }
                // Refresh the data in the collection view
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
//    func addMealInfo(meal: RAMealsDetailsAPIResponse) {
//        self.item = meal.meals
//        self.detailTitleLabel.text  = self.item.first?.strMeal
//        self.downloadImage(fromURL: self.item.first?.strMealThumb ?? "missing")
//
//        self.instructionsLabel.text =
//             """
//             Instructions
//             \(self.item.first?.strInstructions ?? "")
//             """
//
//        var getIngredients =
//                """
//                Ingredients
//                \(self.item.first?.strIngredient1 ?? "") \(self.item.first?.strMeasure1 ?? ""), \
//                \(self.item.first?.strIngredient2 ?? "") \(self.item.first?.strMeasure2 ?? ""), \
//                \(self.item.first?.strIngredient3 ?? "") \(self.item.first?.strMeasure3 ?? ""), \
//                \(self.item.first?.strIngredient4 ?? "") \(self.item.first?.strMeasure4 ?? ""), \
//                \(self.item.first?.strIngredient5 ?? "") \(self.item.first?.strMeasure5 ?? ""), \
//                \(self.item.first?.strIngredient6 ?? "") \(self.item.first?.strMeasure6 ?? ""), \
//                \(self.item.first?.strIngredient7 ?? "") \(self.item.first?.strMeasure7 ?? ""), \
//                \(self.item.first?.strIngredient8 ?? "") \(self.item.first?.strMeasure8 ?? ""), \
//                \(self.item.first?.strIngredient9 ?? "") \(self.item.first?.strMeasure9 ?? ""), \
//                \(self.item.first?.strIngredient10 ?? "") \(self.item.first?.strMeasure10 ?? ""), \
//                \(self.item.first?.strIngredient11 ?? "") \(self.item.first?.strMeasure11 ?? ""), \
//                \(self.item.first?.strIngredient12 ?? "") \(self.item.first?.strMeasure12 ?? ""), \
//                \(self.item.first?.strIngredient13 ?? "") \(self.item.first?.strMeasure13 ?? ""), \
//                \(self.item.first?.strIngredient14 ?? "") \(self.item.first?.strMeasure14 ?? ""), \
//                \(self.item.first?.strIngredient15 ?? "") \(self.item.first?.strMeasure15 ?? ""), \
//                \(self.item.first?.strIngredient16 ?? "") \(self.item.first?.strMeasure16 ?? ""), \
//                \(self.item.first?.strIngredient17 ?? "") \(self.item.first?.strMeasure17 ?? ""), \
//                \(self.item.first?.strIngredient18 ?? "") \(self.item.first?.strMeasure18 ?? ""), \
//                \(self.item.first?.strIngredient19 ?? "") \(self.item.first?.strMeasure19 ?? ""), \
//                \(self.item.first?.strIngredient20 ?? "") \(self.item.first?.strMeasure20 ?? "")
//                """.replacingOccurrences(of: " ,", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
//
//        if getIngredients.last == "," {
//            _ = getIngredients.popLast()
//        }
//        self.ingredientsLabel.text = getIngredients + "."
//        self.detailImageView.isHidden = false
//        self.detailTitleLabel.isHidden = false
//        self.instructionsLabel.isHidden = false
//        self.ingredientsLabel.isHidden = false
//    }
    
}
