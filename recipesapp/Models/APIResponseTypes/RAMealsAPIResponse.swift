//
//  RAMealsAPIResponse.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/19/23.
//

import Foundation

struct RAMealsAPIResponse: Codable {
    let meals: [RAMealModel]
}
