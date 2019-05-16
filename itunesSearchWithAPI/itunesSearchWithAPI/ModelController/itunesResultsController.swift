//
//  itunesResultsController.swift
//  itunesSearchWithAPI
//
//  Created by Kaden Hendrickson on 5/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class itunesResultsController {
    
    static let baseURL = URL(string: "https://itunes.apple.com/")
    
    static func searchItunesWith(searchTerm: String, completion: @escaping ([itunesResults]) -> Void) {
        guard var url = baseURL else { completion([]); return }
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let termQuery = URLQueryItem(name: "term", value: searchTerm)
        let mediaQuery = URLQueryItem(name: "media", value: "music")
        components?.queryItems = [termQuery, mediaQuery]
        
        guard let finalURL = components?.url else {completion([]); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("😝Error fetching items for search term '\(searchTerm)' : \(error.localizedDescription)😝")
                completion([]); return
            }
            guard let data = data else { print("🤬"); completion([]); return }
            
            do {
                let topLevelJSON = try JSONDecoder().decode(TopLevelItunesResults.self, from: data)
                let itunesResultsArray = topLevelJSON.results
                completion(itunesResultsArray)
                
            } catch {
                print("😝 There was an error decoding itunesResults! : \(error.localizedDescription)😝")
            }
        }.resume()
    }
    
    static func fetchImageWith(itunesItem: itunesResults, completion: @escaping (UIImage?) -> Void) {
        guard let url = itunesItem.imageURL else {completion(nil); return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("😝There was an error fetching \(itunesItem.track)! : \(error.localizedDescription)😝")
                completion(nil); return
            }
            guard let data = data else {print("🤬"); completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
