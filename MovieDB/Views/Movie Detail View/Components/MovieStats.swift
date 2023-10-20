//
//  MovieStats.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 19/10/23.
//

import SwiftUI

struct MovieStats: View {
    var releaseData: String?
    var ratings: Double?
    var popularity: Double?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text("Release Date")
                .font(.title3)
                .foregroundColor(Color.gray.opacity(0.9))
            
            Text(releaseData ?? "--")
                .foregroundColor(Color.black.opacity(0.6))
            Spacer()
            Text("⭐️ Rating")
                .font(.title3)
                .foregroundColor(Color.gray.opacity(0.9))
            Text(String(ratings ?? 0.0))
                .foregroundColor(Color.black.opacity(0.6))
            Spacer()
            Text("❤️ Popularity")
                .font(.title3)
                .foregroundColor(Color.gray.opacity(0.9))
            Text(String(popularity ?? 0.0))
                .foregroundColor(Color.black.opacity(0.6))
            Spacer()
        }
    }
}

struct MovieStats_Previews: PreviewProvider {
    static var previews: some View {
        MovieStats()
    }
}
