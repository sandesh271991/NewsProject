//
//  NewsService.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 28/07/24.
//

import Foundation

class NewsService {
    private let apiKey = "e459ea80d782405b8f4154e61190979c"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    func fetchArticles(for category: String, completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: "\(baseURL)?category=\(category)&apiKey=\(apiKey)") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error fetching articles: \(String(describing: error))")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                completion(response.articles)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
