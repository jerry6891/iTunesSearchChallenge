//
//  ContentView.swift
//  iTunesSearchChallenge
//
//  Created by Jerry Lozano on 06/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    SearchBar()
                }
                .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                .shadow(color: .black.opacity(0.5), radius: 10, x: 3, y: 3)
                
                
                EmptyStateView()
            }
            .navigationBarTitle("iTunes Search API")
        }
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
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type A Song, Artist, or Album Name..."
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.borderStyle = .none
        // searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Type A Song, Artist, or Album Name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.80)])
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {}
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator()
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
