//
//  ContentView.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieListModel: MovieListModel = MovieListModel()
    
    
    var body: some View {
        switch movieListModel.popularMoviesResult {
        case let .success(popularMovieResult):
            MovieList(movieList: popularMovieResult.results ?? [Movie]())
                .refreshable {
                    await movieListModel.fetchMovieList()
                }
        default:
            
            VStack {
                ProgressView()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .task {
                        await movieListModel.fetchMovieList()
                    }
                Text("Loading Movies ...")
                    .font(.title3)
                    .foregroundColor(.orange)
                    .bold()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
