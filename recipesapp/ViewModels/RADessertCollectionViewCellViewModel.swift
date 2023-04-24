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
    let mealId: String
    
    init(dessertName: String, dessertImageUrl: URL?, mealId: String) {
        self.dessertName = dessertName
        self.dessertImageUrl = dessertImageUrl
        self.mealId = mealId
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = dessertImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
                
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
}
