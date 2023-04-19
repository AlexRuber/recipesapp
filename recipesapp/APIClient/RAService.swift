//
//  RAService.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/18/23.
//

import Foundation


/// PrimaryAPI Service object to get Dessert Data
final class RAService {
    
    /// Shared singleton instance since the project is small (we can use dependency injection later)
    static let shared = RAService()
    
    /// Privatized Constructor
    private init() {}
    
    /// Send Dessert API Call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with dessert data or error
    public func execute(_ request: RARequest, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    
}
