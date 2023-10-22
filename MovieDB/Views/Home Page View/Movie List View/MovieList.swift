//
//  MovieList.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 20/10/23.
//

import SwiftUI

struct MovieList: View {
    
    var movieList: [Movie]
    
    var body: some View {
        List {
            ForEach(movieList) { movie in
                NavigationLink {
                    MovieDetail(movie: movie)
                        .navigationTitle(movie.title ?? "Movie Title")
                } label: {
                    MovieRow(movie: movie)
                }
            }
        }
            .listStyle(.plain)
            .scrollDismissesKeyboard(.immediately)
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(movieList: [Movie]())
    }
}
