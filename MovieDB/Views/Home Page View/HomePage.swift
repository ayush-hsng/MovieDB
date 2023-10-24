//
//  HomePage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 21/10/23.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var moviesByPopularityViewModel: MoviesByPopularityViewModel
    @ObservedObject var moviesByTitleViewModel: MoviesByTitleViewModel
    @State private var currentMoviesByPopularityPage: Int = 1
    @State private var currentMoviesByTitlePage: Int = 1
    @State private var viewContext: MovieListContext = .byPopularity
    @State private var searchTitle: String = ""
    
    var loadingView: some View {
        LoadingPage()
            .task {
                switch self.viewContext {
                case .byPopularity:
                    await moviesByPopularityViewModel.fetchMoviesByPopularity(for: 1)
                case .byTitle:
                    await self.moviesByTitleViewModel.fetchMoviesByTitle(self.searchTitle, for: 1)
                }
            }
    }
   
    var body: some View {
        NavigationStack {
            switch self.viewContext {
            case .byPopularity:
                switch self.moviesByPopularityViewModel.modelState {
                case .empty:
                    self.loadingView
                case .working(let results):
                    Spacer()
                    SearchBar(moviesSearchController: moviesByTitleViewModel, searchTitle: $searchTitle, viewContext: $viewContext, currentPage: $currentMoviesByTitlePage)
                    MovieList(movieList: results.results[currentMoviesByPopularityPage]?.results ?? [Movie]())
                        .refreshable {
                            await moviesByPopularityViewModel.fetchMoviesByPopularity(for: currentMoviesByPopularityPage)
                        }
                    PageControll(pageController: moviesByPopularityViewModel,currentPage: $currentMoviesByPopularityPage)
                case .currupt:
                    ErrorDisplay()
                }
            case .byTitle:
                switch self.moviesByTitleViewModel.modelState {
                case .empty:
                    self.loadingView
                case .working(let results):
                    Spacer()
                    SearchBar(moviesSearchController: moviesByTitleViewModel, searchTitle: $searchTitle, viewContext: $viewContext, currentPage: $currentMoviesByTitlePage)
                    MovieList(movieList: results.results[currentMoviesByTitlePage]?.results ?? [Movie]())
                        .refreshable {
                            await moviesByTitleViewModel.fetchMoviesByTitle(searchTitle, for: currentMoviesByTitlePage)
                        }
                    PageControll(pageController: moviesByTitleViewModel,currentPage: $currentMoviesByTitlePage)
                case .currupt:
                    ErrorDisplay()
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(moviesByPopularityViewModel: MoviesByPopularityViewModel(), moviesByTitleViewModel: MoviesByTitleViewModel())
    }
}
