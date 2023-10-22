//
//  GoBackButton.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct GoBackButton: View {
    let isEnabled: Bool
    var movieListModel: MovieListModel
    @Binding var currentPage: Int
    
    var body: some View {
        if self.isEnabled {
            Image(systemName: "backward.frame.fill")
                .foregroundColor(.blue)
                .onTapGesture {
                    Task {
                        self.currentPage -= 1
                        await self.movieListModel.fetchMovieList(for: self.currentPage)
                    }
                }
        }else {
            Image(systemName: "backward.frame.fill")
                .foregroundColor(.gray)
        }
    }
}

struct GoBackButton_Previews: PreviewProvider {
    static var previews: some View {
        GoBackButton( isEnabled: true, movieListModel: MovieListModel(), currentPage: .constant(1))
    }
}
