//
//  RADessertCollectionViewCellViewModel.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/20/23.
//

import Foundation

final class RADessertCollectionViewCellViewModel {
    
    let dessertName: String
    let dessertImageUrl: URL?
    
    init(dessertName: String, dessertImageUrl: URL?) {
        self.dessertName = dessertName
        self.dessertImageUrl = dessertImageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = dessertImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
}
