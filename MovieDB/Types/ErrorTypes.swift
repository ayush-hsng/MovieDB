//
//  ErrorTypes.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 23/10/23.
//

import Foundation

enum ModelState<T> {
    case empty
    case working(T)
    case currupt
}

enum GetMoviesListErrorResult: Error {
    case notFound
    case invalidRequest
    case curruptHandler
}

enum ResponseError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidRequest
}
