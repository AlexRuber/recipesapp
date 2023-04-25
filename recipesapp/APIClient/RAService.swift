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
    
    enum RAServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send API Call (e.g Dessert API Get Request)
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with dessert data or error
    public func execute<T:Codable>(_ request: RARequest,
                                   expecting type: T.Type,
                                   completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RAServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RAServiceError.failedToGetData))
                return
            }
            
            // Decode the response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
                // We need to decode it to the type that the completion is expecting (Type T Generic)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    
    // MARK: - Private
    
    private func request(from raRequest: RARequest) -> URLRequest? {
        guard let url = raRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = raRequest.httpMethod
        return request
    }
    
    
}
