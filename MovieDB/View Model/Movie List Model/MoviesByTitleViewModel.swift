//
//  MoviesByTitleViewModel.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 23/10/23.
//

import Foundation

class MoviesByTitleViewModel: ObservableObject, MoviesSearchController {
    
    struct ResultsRecord {
        let totalPages: Int
        let results: [Int: APIResponse]
    }
    
    @Published var modelState: ModelState<ResultsRecord> = .empty
    private let requestHandler: RequestHandler = RequestHandler()
    private var searchTitle: String?
    
    private func isValid(page: Int) -> Bool {
        return ((page > 0) && (page <= self.getTotalPages()))
    }
    
    func getTotalPages() -> Int {
        switch self.modelState {
        case .working(let resultsRecord):
            return resultsRecord.totalPages
        default:
            return 0
        }
    }
    
    func getMovies(byTitle title: String) -> [Movie]{
        return [Movie]()
    }

    func goToNextPageAllowed(for currentPage: Int) -> Bool {
        return self.isValid(page: currentPage + 1)
    }
    
    func goToPreviousPageAllowed(for currentPage: Int) -> Bool {
        return self.isValid(page: currentPage - 1)
    }
    
    @MainActor
    func loadPage(_ page: Int) async {
        guard let searchTitle = self.searchTitle else {
            fatalError("Reached Invalid State: Model not set for searching titles")
        }
        await self.fetchMoviesByTitle( searchTitle, for: page)
    }
    
    
    func setForSearching(title: String) {
        if searchTitle != title {
            self.searchTitle = title
        }
    }
    @MainActor
    func resetController() {
        self.modelState = .empty
    }
    
    func getMoviesByTitle(_ title: String, for page: Int = 1) -> Result<[Movie], GetMoviesListErrorResult>  {
        switch modelState {
            //
        case .working(let resultsRecord) :
            guard isValid(page: page) else {
                return .failure(.invalidRequest)
            }
            guard let result = resultsRecord.results[page] else {
                return .failure(.notFound)
            }
            return .success(result.results)
            
            //
        case .empty:
            return .failure(.invalidRequest)
        case .currupt:
            return .failure(.curruptHandler)
        }
    }
    
    @MainActor
    func fetchMoviesByTitle(_ title: String, for page: Int) async {
        let response = await requestHandler.handleRequest(for: RequestType.moviesByTitle(title: title, page: page))
        switch response {
            //
        case .success(let movieByTitleResult):
            switch self.modelState {
                //
            case .empty:
                self.modelState = .working(ResultsRecord(totalPages: movieByTitleResult.total_pages, results: [1: movieByTitleResult]))
            case .working(let searchResults):
                var moviesByTitleResults = searchResults.results
                moviesByTitleResults[page] = movieByTitleResult
                self.modelState = .working(ResultsRecord(totalPages: searchResults.totalPages, results: moviesByTitleResults))
                //
            case .currupt:
                self.modelState = .empty
            }
            //
        case .failure:
            break
        }
    }
}
