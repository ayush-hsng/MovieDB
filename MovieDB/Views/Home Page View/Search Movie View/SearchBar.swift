//
//  SearchBar.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct SearchBar: View {
    var moviesSearchController: MoviesSearchController
    
    @Binding var searchTitle: String
    @Binding var viewContext: MovieListContext
    @Binding var currentPage: Int
    
    @MainActor
    var cancelButtonView: some View {
        Button {
            self.searchTitle = ""
            self.setViewContext(to: .byPopularity)
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
        }
    }
    
    @MainActor
    func resetSearchController() {
        self.currentPage = 1
        self.moviesSearchController.setForSearching(title: self.searchTitle)
        self.moviesSearchController.resetController()
    }
    
    func setViewContext(to context: MovieListContext) {
        self.viewContext = context
    }
    
    @MainActor
    var searchButton: some View {
        Button {
            if !self.searchTitle.isEmpty {
                switch self.viewContext {
                case .byPopularity:
                    self.resetSearchController()
                    self.setViewContext(to: .byTitle)
                case .byTitle:
                    self.resetSearchController()
                }
            }
        } label: {
            Image(systemName: "magnifyingglass")
            Text("Search")
        }.foregroundColor(.gray)
    }

    
    var body: some View {
        HStack {
            TextField("Enter movie title", text: $searchTitle)
            searchButton
            switch viewContext {
            case .byPopularity:
                EmptyView()
            case .byTitle:
                cancelButtonView
            }
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(moviesSearchController: MoviesByTitleViewModel(), searchTitle: .constant("Harry"), viewContext: .constant(.byTitle), currentPage: .constant(1))
    }
}
