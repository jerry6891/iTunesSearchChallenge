//
//  iTunesSearchChallengeApp.swift
//  iTunesSearchChallenge
//
//  Created by Jerry Lozano on 06/10/22.
//

import SwiftUI

@main
struct iTunesSearchChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongListViewModel())
        }
    }
}
