//
//  RoundedRectangleImage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 20/10/23.
//

import SwiftUI

struct RoundedRectangleImage: View {
    var placeHolderImage: Image = Image("background")
    var cornerRadius: CGFloat = 20
    var imageFileName: String?
    var imagePath: String? {
        guard let imageFileName = imageFileName else {
            return nil
        }
        return POSTER_IMAGE_BASE_PATH + imageFileName
    }
    
    var body: some View {
        
        Group {
            if let imagePath = imagePath {
                AsyncImage(url: URL(string: imagePath)) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                } placeholder: {
                    
                    placeHolderImage
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
            }else {
                placeHolderImage
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
        }

    }
}

struct RoundedRectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleImage()
    }
}
