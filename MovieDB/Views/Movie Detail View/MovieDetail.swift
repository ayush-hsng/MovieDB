//
//  MovieDetail.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

struct MovieDetail: View {
    
    var movie: Movie
    let posterImageFrame: CGSize = CGSize(width: 200, height: 300)
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading ) {
                
                HStack {
                    RoundedRectangleImage(imageFrame: posterImageFrame, imageFileName: movie.poster_path)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                    
                    MovieStats(releaseData: movie.release_date, ratings: movie.vote_average, popularity: movie.popularity)
                    
                    Spacer()
                }
                .padding()
                .frame(height: 320)
                
                MovieDescription(movieOverview: movie.overview)
                    .padding(EdgeInsets(top: 32, leading: 20, bottom: 0, trailing: 16 ))
                
                
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
        }
        
    }
}

struct MovieDetail_Previews: PreviewProvider {
    
    
    static var previews: some View {
        MovieDetail(movie: Movie())
    }
}
