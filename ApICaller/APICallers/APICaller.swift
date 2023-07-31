//
//  APIStructure.swift
//  ApICaller
//
//  Created by Kavin Jha on 06/07/23.
//

import Foundation

final class APICaller {
    
    // singleton design pattern
    static let shared = APICaller()
    private init() {}
    
    func request(url: URL, onCompletion: @escaping (Data) -> ()){
                
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

struct NewsApiResponse: Codable {

    let articles : [PostData]
}


struct PostData: Codable {
    

    let title : String
    let urlToImage: String
    let content: String
    let publishedAt: String
    let url: String

}
