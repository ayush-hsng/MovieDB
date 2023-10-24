//
//  ContentView.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var moviesByPopularityViewModel: MoviesByPopularityViewModel
    @ObservedObject var moviesByTitleViewModel: MoviesByTitleViewModel
    
    var body: some View {
        HomePage(moviesByPopularityViewModel: moviesByPopularityViewModel, moviesByTitleViewModel: moviesByTitleViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(moviesByPopularityViewModel: MoviesByPopularityViewModel(), moviesByTitleViewModel: MoviesByTitleViewModel())
    }
}
