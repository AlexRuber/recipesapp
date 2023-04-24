//
//  RAMealDetailViewViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import Foundation


final class RAMealDetailViewViewModel {
    
    private let meal: RAMealModel
    
    init(meal: RAMealModel) {
        self.meal = meal
    }
    
    public var mealTitle: String {
        return meal.strMeal.capitalized
    }
    
}
