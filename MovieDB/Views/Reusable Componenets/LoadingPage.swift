//
//  LoadingPage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 21/10/23.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            Text("Loading Movies ...")
                .font(.title3)
                .foregroundColor(.orange)
                .bold()
        }
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
