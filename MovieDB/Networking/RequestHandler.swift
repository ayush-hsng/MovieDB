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
    case moviesByTitle(title:String, page: Int)
}

class RequestHandler {
    var decoder: JSONDecoder = JSONDecoder()
    
    func handleRequest(for requestType: RequestType) async -> Result<APIResponse, Error> {
        switch requestType {
        case let .moviesByPopularity(page):
            return await self.handleMovieByPopularityRequest(byPage: page)
        case let .moviesByTitle(title, page):
            return await self.handleMovieByTitleRequest(title, byPage: page)
        }
    }
    
    private func handleMovieByPopularityRequest(byPage page: Int) async -> Result<APIResponse, Error> {
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
            
            guard let popularMoviesData = try? self.decoder.decode(APIResponse.self, from: data) else {
                return .failure(ResponseError.invalidData)
            }
            
            return .success(popularMoviesData)
        }catch {
            print(error)
            return .failure(ResponseError.invalidRequest)
        }
    }
    
    private func handleMovieByTitleRequest(_ title: String, byPage page: Int) async -> Result<APIResponse, Error> {
        let queryList = [   "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : String(page),
                            "query" : title]
        
        let headers = ["accept": "application/json"]
        
        let urlString = API_SEARCH_MOVIES_URL_STRING
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
            
            guard let popularMoviesData = try? self.decoder.decode(APIResponse.self, from: data) else {
                return .failure(ResponseError.invalidData)
            }
            
            return .success(popularMoviesData)
        }catch {
            print(error)
            return .failure(ResponseError.invalidRequest)
        }
        
    }

}
