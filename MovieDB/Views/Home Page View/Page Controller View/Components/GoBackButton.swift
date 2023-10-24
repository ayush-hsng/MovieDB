//
//  GoBackButton.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct GoBackButton: View {
    var pageController: PageController
    @Binding var currentPage: Int
    
    var body: some View {
        if self.pageController.goToPreviousPageAllowed(for: currentPage) {
            Image(systemName: "backward.frame.fill")
                .foregroundColor(.blue)
                .onTapGesture {
                    Task {
                        self.currentPage -= 1
                        await self.pageController.loadPage(currentPage)
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
        GoBackButton(pageController: MoviesByPopularityViewModel(), currentPage: .constant(1))
    }
}
