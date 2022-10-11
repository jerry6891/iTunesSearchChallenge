//
//  ContentView.swift
//  iTunesSearchChallenge
//
//  Created by Jerry Lozano on 06/10/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: SongListViewModel
    
    // MARK: - UI Development
    var body: some View {
        NavigationStack {
            VStack {
                VStack { SearchBar(searchTerm: $viewModel.searchTerm) }
                .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                .shadow(color: .black.opacity(0.5), radius: 10, x: 3, y: 3)

                if viewModel.songs.isEmpty {
                    EmptyStateView()
                } else {
                     List(viewModel.songs) { song in
                         SongView(song: song)
                     }
                     .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("iTunes Search API")
        }
    }
}

// MARK: - Extensions + Strcutures
struct SongView: View {
    @ObservedObject var song: SongViewModel
    var body: some View {
        HStack {
            ArtworkView(image: song.artwork)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct ArtworkView: View {
    let image: Image?
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "music.note")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start Searching For Music...")
                .font(.title2)
            Spacer()
        }
        .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))
        .foregroundColor(Color.indigo)
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type A Song, Artist, or Album Name..."
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.borderStyle = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {}
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            
            let keyWindow = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first
            keyWindow?.endEditing(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SongListViewModel())
    }
}
