//
//  MoviesByPopularityViewModel.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 23/10/23.
//

import Foundation

class MoviesByPopularityViewModel: ObservableObject, PageController {
    
    struct ResultsRecord {
        let totalPages: Int
        let results: [Int: APIResponse]
    }
    
    @Published var modelState: ModelState<ResultsRecord> = .empty
    private let requestHandler: RequestHandler = RequestHandler()
    
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
        await self.fetchMoviesByPopularity(for: page)
    }
    
    @MainActor
    func getMoviesByPopularity(for page: Int = 1) -> Result<[Movie],GetMoviesListErrorResult> {
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
    func fetchMoviesByPopularity(for page: Int = 1) async {
        let result = await self.requestHandler.handleRequest(for: RequestType.moviesByPopularity(page: page))
        switch result {
            //
        case .success(let moviesByPopularityResult):
            print(moviesByPopularityResult)
            switch self.modelState {
            case .empty:
                guard page == 1 else {
                    self.modelState = .currupt
                    return
                }
                let newRecord = ResultsRecord(totalPages: moviesByPopularityResult.total_pages, results: [page:moviesByPopularityResult])
                self.modelState = .working(newRecord)
                print(self.getTotalPages())
            case .working(let resultsRecord):
                guard isValid(page: page) else {
                    self.modelState = .currupt
                    return
                }
                var newResults = resultsRecord.results
                newResults[page] = moviesByPopularityResult
                let newRecord = ResultsRecord(totalPages: moviesByPopularityResult.total_pages, results: newResults)
                self.modelState = .working(newRecord)
            case .currupt:
                break
            }
            
            //
        case .failure:
            self.modelState = .currupt
        }
    }
}
