//
//  PageControll.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct PageControll: View {
    var movieListModel: MovieListModel
    let goBackButtonEnabled: Bool
    let goNextButtonEnabled: Bool
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            
            GoBackButton(isEnabled: self.goBackButtonEnabled, movieListModel: self.movieListModel, currentPage: $currentPage)
            
            Spacer()
            Text("Page \(self.currentPage) of \(self.movieListModel.getTotalPages())")
            Spacer()
            
            GoNextButton(isEnabled: self.goNextButtonEnabled, movieListModel: self.movieListModel, currentPage: $currentPage)
            
        }.padding()
    }
}

struct PageControll_Previews: PreviewProvider {
    static var previews: some View {
        PageControll(movieListModel: MovieListModel(), goBackButtonEnabled: false, goNextButtonEnabled: false, currentPage: .constant(1))
    }
}
