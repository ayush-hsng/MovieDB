//
//  MovieRow.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 20/10/23.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    let posterImageFrame: CGSize = CGSize(width: 64, height: 96)
    
    var body: some View {
        HStack {
            RoundedRectangleImage(imageFrame:posterImageFrame, imageFileName: movie.poster_path)            
            VStack(alignment: .leading) {
                Spacer()
                Text(movie.title ?? "Title")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black.opacity(0.9))
                Spacer()
                Text(movie.overview ?? "Description")
                    .lineLimit(2)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: Movie())
    }
}
