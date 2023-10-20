//
//  MovieRow.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 20/10/23.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            RoundedRectangleImage(cornerRadius: 8, imageFileName: movie.poster_path)
                .frame(width: 72, height: 96)
            
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
