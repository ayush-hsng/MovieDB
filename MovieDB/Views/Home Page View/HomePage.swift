//
//  HomePage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 21/10/23.
//

import SwiftUI

enum MovieListContext {
    case byPopularity
    case byTitle
}

struct HomePage: View {
    @ObservedObject var moviesByPopularityViewModel: MoviesByPopularityViewModel
    @ObservedObject var moviesByTitleViewModel: MoviesByTitleViewModel
    @State private var currentMoviesByPopularityPage: Int = 1
    @State private var currentMoviesByTitlePage: Int = 1
    @State private var viewContext: MovieListContext = .byPopularity
    @State private var searchTitle: String = ""
    
//    var cancelButtonView: some View {
//        Button {
//            self.searchTitle = ""
//            self.currentMoviesByTitlePage = 1
//            self.moviesByTitleViewModel.resetController()
//            self.viewContext = .byPopularity
//        } label: {
//            Image(systemName: "xmark.circle.fill")
//                .foregroundColor(.red)
//        }
//    }
    
    
    var body: some View {
        VStack {
            NavigationStack {
                switch self.viewContext {
                case .byPopularity:
                    switch self.moviesByPopularityViewModel.modelState {
                    case .empty:
                        LoadingPage()
                            .task {
                                await moviesByPopularityViewModel.fetchMoviesByPopularity(for: 1)
                            }
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
                        LoadingPage()
                            .task {
                                self.moviesByTitleViewModel.setForSearching(title: self.searchTitle)
                                await self.moviesByTitleViewModel.fetchMoviesByTitle(self.searchTitle, for: 1)
                            }
                    case .working(let results):
                        Spacer()
                        HStack {
                            SearchBar(moviesSearchController: moviesByTitleViewModel, searchTitle: $searchTitle, viewContext: $viewContext, currentPage: $currentMoviesByTitlePage)
                        }.padding()
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
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(moviesByPopularityViewModel: MoviesByPopularityViewModel(), moviesByTitleViewModel: MoviesByTitleViewModel())
    }
}
