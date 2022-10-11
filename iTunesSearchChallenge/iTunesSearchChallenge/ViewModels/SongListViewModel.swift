//
//  SongListViewModel.swift
//  iTunesSearchChallenge
//
//  Created by Jerry Lozano on 10/10/22.
//

import Foundation
import SwiftUI
import Combine

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel: DataViewModel = DataViewModel()
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        artworkLoader.reset()
        
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach {
                self.appendSong(song: $0)
            }
        }
    }
    
    private func appendSong(song: Song) {
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
        
        artworkLoader.loadArtwork(forSong: song) { image in
            DispatchQueue.main.async {
                songViewModel.artwork = image
            }
        }
    }
}

class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    @Published var artwork: Image?
    
    init(song: Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
    }
}
