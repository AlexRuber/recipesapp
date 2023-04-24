//
//  RAMealDetailsAPIResponse.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import Foundation

struct RAMealsDetailsAPIResponse: Codable {
    let meals: [RAMealDetailsModel]
}
