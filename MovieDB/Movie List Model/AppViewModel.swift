//
//  AppViewModel.swift
//  MovieDB
//
//  Created by Ayush Kumar Sinha on 23/10/23.
//

import Foundation
import SwiftUI

class AppViewModel {
    @ObservedObject var moviesByPopularityViewModel: MoviesByPopularityViewModel = MoviesByPopularityViewModel()
    @ObservedObject var moviesByTitleViewModel: MoviesByTitleViewModel = MoviesByTitleViewModel()
}
