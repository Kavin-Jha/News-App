//
//  ApiCallerComments.swift
//  ApICaller
//
//  Created by Kavin Jha on 13/07/23.
//

import Foundation


final class ApiCallerComments {
    
    
    static let shared = ApiCallerComments()
    
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

struct CommentsData: Codable {
    
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
