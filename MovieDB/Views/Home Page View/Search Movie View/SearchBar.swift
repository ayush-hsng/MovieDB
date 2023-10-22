//
//  SearchBar.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTitle: String
    @ObservedObject var movieListModel: MovieListModel
    @Binding var movieListContext: MovieListContext
    
    var body: some View {
        HStack {
            TextField("Enter movie title", text: $searchTitle)
            Button {
                if searchTitle.isEmpty {
                    movieListContext = .byPopularity
                }else {
                    Task {
                        await movieListModel.fetchMovieList(for: 1)
                        movieListContext = .byTitle
                    }
                }
            } label: {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .foregroundColor(.gray)
            
            switch self.movieListContext {
            case .byPopularity:
                EmptyView()
            case .byTitle:
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        self.movieListContext = .byPopularity
                    }
            }
            
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchTitle: .constant(""), movieListModel: MovieListModel(), movieListContext: .constant(.byTitle))
    }
}
