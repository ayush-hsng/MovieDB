//
//  GoNextButton.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct GoNextButton: View {
    var pageController: PageController
    @Binding var currentPage: Int
    
    var body: some View {
        if pageController.goToNextPageAllowed(for: currentPage) {
            Image(systemName: "forward.frame.fill")
                .foregroundColor(.blue)
                .onTapGesture {
                    Task {
                        self.currentPage += 1
                        await self.pageController.loadPage(currentPage)
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
        GoNextButton(pageController: MoviesByPopularityViewModel(), currentPage: .constant(1))
    }
}
