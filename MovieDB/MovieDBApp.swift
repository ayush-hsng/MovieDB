//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

@main
struct MovieDBApp: App {
    @ObservedObject var movieListModel: MovieListModel = MovieListModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(movieListModel: MovieListModel())
        }
    }
}
