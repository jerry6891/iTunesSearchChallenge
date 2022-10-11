//
//  DataModel.swift
//  iTunesSearchChallenge
//
//  Created by Jerry Lozano on 10/10/22.
//

import Foundation

// https://itunes.apple.com/search?term=colplay&entity=song

struct SongResponse: Decodable {
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}

struct Song: Decodable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case artworkUrl = "artworkUrl60"
    }
}
