//
//  HomePage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 21/10/23.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var movieListModel: MovieListModel
    @State private var currentPage: Int = 1
    
    var body: some View {
        VStack {
            Group {
                switch movieListModel.popularMoviesResult {
                case let .success(popularMovieResult):
                    MovieList(movieList: popularMovieResult.results ?? [Movie]())
                        .refreshable {
                            await movieListModel.fetchMovieList(for: 1)
                        }
                    
                    PageControll(
                        movieListModel: movieListModel,
                        goBackButtonEnabled: self.movieListModel.goToPreviousPageAllowed(),
                        goNextButtonEnabled: self.movieListModel.goToNextPageAllowed(),
                        currentPage: $currentPage)
                case .empty:
                    LoadingPage()
                        .task {
                            await movieListModel.fetchMovieList(for: 1)
                        }
                default:
                    LoadingPage()
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(movieListModel: MovieListModel())
    }
}
