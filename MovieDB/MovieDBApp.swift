//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

@main
struct MovieDBApp: App {
    
    @ObservedObject var movieListModel: MoviesByPopularityViewModel = MoviesByPopularityViewModel()
    
    var appViewModel: AppViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(moviesByPopularityViewModel: appViewModel.moviesByPopularityViewModel, moviesByTitleViewModel: appViewModel.moviesByTitleViewModel)
        }
    }
}
