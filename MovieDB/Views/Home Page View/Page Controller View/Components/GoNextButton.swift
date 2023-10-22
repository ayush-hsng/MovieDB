//
//  GoNextButton.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct GoNextButton: View {
    let isEnabled: Bool
    var movieListModel: MovieListModel
    @Binding var currentPage: Int
    
    var body: some View {
        
        if isEnabled {
            Image(systemName: "forward.frame.fill")
                .foregroundColor(.blue)
                .onTapGesture {
                    Task {
                        self.currentPage += 1
                        await movieListModel.fetchMovieList(for: currentPage)
                    }
                }
        }else {
            Image(systemName: "forward.frame.fill")
                .foregroundColor(.gray)
        }
    }
}

struct GoNextButton_Previews: PreviewProvider {
    static var previews: some View {
        GoBackButton( isEnabled: true, movieListModel: MovieListModel(), currentPage: .constant(1))
    }
}
