//
//  MovieListModel.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import Foundation
import SwiftUI

enum PopularMovieResultsType<Success> {
    case empty
    case success(Success)
    case failure(Error)
}


class MovieListModel: ObservableObject {
    @Published var popularMoviesResult: PopularMovieResultsType<PopularMovieResult> = .empty
    private let requestHandler: RequestHandler = RequestHandler()
    
    
    @MainActor
    func fetchMovieList(for page: Int = 1) async {
        
        let response = await requestHandler.handleRequest(of: .moviesByPopularity(page: page))
        switch response {
        case let .success(popularMoviesResponse):
            self.popularMoviesResult = .success(popularMoviesResponse)
        case let .failure(error):
            self.popularMoviesResult = .failure(error)
        }
    }
    
}
