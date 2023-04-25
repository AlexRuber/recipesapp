//
//  RAEndpoint.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RAEndpoint: String, CaseIterable, Hashable {
    
    /// Later on we'd want to expand and separate this out by category Dessert, Seafood etc.
    
    // Filter
    /// Endpoint to get dessert category meals
    case dessert = "filter.php?c=Dessert"
    case seafood = "filter.php?c=Seafood"
    
    // Lookup
    /// Endpoint to get specific meal details
    case mealDetails = "lookup.php"
    
}

