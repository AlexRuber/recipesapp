//
//  RAEndpoint.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RMEndpoint: String {
    
    /// Endpoint to get meals
    case meal // "meal" as a string
    
    /// Endpoint to get meal details
    case mealDetails
    
}
