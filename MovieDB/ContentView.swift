//
//  ContentView.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieListModel: MovieListModel
    
    var body: some View {
        HomePage(movieListModel: movieListModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(movieListModel: MovieListModel())
    }
}
