//
//  RARequest.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import Foundation


/// Object that represents single API call
final class RARequest {
    
    // ex: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
    
    // https://themealdb.com/api/json/v1/1/lookup.php?i=52855
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://themealdb.com/api/json/v1/1"
    }
    
    /// Endpoint
    private let endpoint: RAEndpoint
    
    /// Unique Path Components for API, if any
    private let pathComponents: Set<String>
    
    /// Query Components for API, if any
    private let queryParameters: [URLQueryItem]

    /// Constructed url for the API Request in String format
    private var urlString: String {
        // https://themealdb.com/api/json/v1/1/lookup.php?i=52855
        // ex: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert

        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        // Filter by category : /filter.php?c=Seafood
        // Lookup meal : /lookup.php?i=52855
        
        if !pathComponents.isEmpty { pathComponents.forEach({ string += "/\($0)"}) }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap ({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    
    /// Computed and constructed API url
    public var url: URL? { return URL(string: urlString) }
    
    /// Desired HTTP Method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: RAEndpoint,
        pathComponents: Set<String> = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RARequest {
    static let getMealDetailsRequest = RARequest(endpoint: .mealDetails)
    static let getAllDesserts = RARequest(endpoint: .dessert)
}
