//
//  RequestHandler.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import Foundation
import SwiftUI

enum RequestType {
    case moviesByPopularity(page: Int)
}

enum ResponseError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidRequest
}

class RequestHandler {
    var decoder: JSONDecoder = JSONDecoder()
    
    func handleRequest(of type: RequestType) async -> Result<PopularMovieResult, Error> {
        switch type {
        case let .moviesByPopularity(page):
            let response = await self.handleMovieByPopularityRequest(byPage: page)
            return response
        }
    }
    
    func handleMovieByPopularityRequest(byPage page: Int) async -> Result<PopularMovieResult, Error> {
        let queryList = [   "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : String(page)]
        
        let headers = ["accept": "application/json"]
        
        let urlString = API_POPULAR_MOVIES_URL_STRING
        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems = queryList.map() { URLQueryItem(name: $0, value: $1)}
        
        guard let url = urlComponent?.url else {
            return .failure(ResponseError.invalidURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(ResponseError.invalidResponse)
            }
            
            guard let popularMoviesData = try? self.decoder.decode(PopularMovieResult.self, from: data) else {
                return .failure(ResponseError.invalidData)
            }
            
            return .success(popularMoviesData)
        }catch {
            print(error)
            return .failure(ResponseError.invalidRequest)
        }
        
    }
    
}
