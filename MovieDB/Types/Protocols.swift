//
//  Protocols.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 23/10/23.
//

import Foundation

protocol PageController {
    func getTotalPages() -> Int
    func goToNextPageAllowed(for currentPage: Int) -> Bool
    func goToPreviousPageAllowed(for currentPage: Int) -> Bool
    func loadPage(_ page:Int) async 
}
