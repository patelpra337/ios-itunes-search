//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by patelpra on 3/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Private Properties
    private let baseURl = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURl, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "result", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil")
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            guard error == nil else {
                NSLog("Error fecthing data: \(String(describing: error)))")
                completion(error)
                return
            }
         
        guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResult.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(error)
            }
        }.resume()
    }
}
