//
//  itunesResults.swift
//  itunesSearchWithAPI
//
//  Created by Kaden Hendrickson on 5/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation


struct TopLevelItunesResults: Decodable {
    let results: [itunesResults]
    let resultCount: Int
}
struct itunesResults: Decodable {
    
    let artist: String?
    let track: String?
    let album: String?
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case track = "trackName"
        case album = "collectionName"
        case imageURL = "artworkUrl100"
    }
}
