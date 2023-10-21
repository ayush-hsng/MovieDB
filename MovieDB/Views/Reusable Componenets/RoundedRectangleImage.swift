//
//  RoundedRectangleImage.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 20/10/23.
//

import SwiftUI

struct RoundedRectangleImage: View {
    var imageFrame: CGSize
    
    var imageFileName: String? = nil
    
    private var cornerRadius: CGFloat {
        return min(imageFrame.width, imageFrame.height) / 10
    }
    
    private var imagePath: String? {
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
                    ProgressView()
                }
            }else {
                Image("background")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
        }
        .frame(width: imageFrame.width, height: imageFrame.height)
        
    }
}

struct RoundedRectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleImage(imageFrame: CGSize(width: 200, height: 300))
    }
}
