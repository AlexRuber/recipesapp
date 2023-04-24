//
//  ImageManager.swift
//  recipesapp
//
//  Created by Mihai Ruber on 4/23/23.
//

import Foundation


final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// Get image content with URL and cache it
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data,Error>) -> Void) {
        
        let key = url.absoluteString as NSString
        
        // Check if the data is already in the cache
        if let data  = imageDataCache.object(forKey: key) {
            print("Using cached image \(data)")
            completion(.success(data as Data))
            return
        }
        
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {  [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            // Cache the image data
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        task.resume()
    }
    
}
