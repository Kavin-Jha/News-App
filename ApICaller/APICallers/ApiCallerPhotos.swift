//
//  ApiCallerPhotos.swift
//  ApICaller
//
//  Created by Kavin Jha on 13/07/23.
//

import Foundation

final class ApicallerPhotos {
    
    
    static let shared = ApicallerPhotos()
    
    func request(url: URL, placeHolderImage: String, onCompletion: @escaping (Data) -> ()){
    
        let task = URLSession.shared.dataTask(with: url){ (data, resp, error) in
            
            guard let data = data else {
                print("no data")
                return
            }
            
            DispatchQueue.main.async {
                onCompletion(data)
            }
            
            
        }
        task.resume()
    }
}

struct PhotosData: Codable {
    
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
