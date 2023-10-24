//
//  PageControll.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 22/10/23.
//

import SwiftUI

struct PageControll: View {
    var pageController: PageController
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            GoBackButton(pageController: self.pageController, currentPage: $currentPage)
            
            Spacer()
            Text("Page \(self.currentPage) of \(self.pageController.getTotalPages())")
            Spacer()
            
            GoNextButton(pageController: self.pageController, currentPage: $currentPage)
            
        }.padding()
    }
}

struct PageControll_Previews: PreviewProvider {
    static var previews: some View {
        PageControll(pageController: MoviesByPopularityViewModel(), currentPage: .constant(1))
    }
}
