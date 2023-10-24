//
//  SearchBar.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTitle: String
    var movieByTitleModel: MoviesByTitleViewModel
    @Binding var viewContext: MovieListContext
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            TextField("Enter movie title", text: $searchTitle)
            Button {
                switch viewContext {
                case .byPopularity:
                    if !searchTitle.isEmpty {
                        self.viewContext = .byTitle
                    }
                case .byTitle:
                    if !searchTitle.isEmpty {
                        self.movieByTitleModel.setModelForSearching(title: searchTitle)
                        self.currentPage = 1
                        self.movieByTitleModel.resetModel()
                    }
                }
            } label: {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }.foregroundColor(.gray)
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchTitle: .constant("Harry"), movieByTitleModel: MoviesByTitleViewModel(), viewContext: .constant(.byTitle), currentPage: .constant(1))
    }
}
