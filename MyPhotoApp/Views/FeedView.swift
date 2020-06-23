//
//  FeedView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 14/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI


func screenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct FeedView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }
    
    var feedListView: some View {
        ScrollView {
           ForEach(self.feedViewModel.posts) { post in
               CardView(post: post)
           }
       }
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            ActivityIndicatorView()
                .onAppear {
                    self.feedViewModel.loadPosts()
                }
            Spacer()
        }
    }
    
    var showView: some View {
        switch self.feedViewModel.viewState {
            case .loading: return AnyView(loadingView)
            default: return AnyView(feedListView)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView()
                Spacer()
                VStack {
                    showView
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feedViewModel: FeedViewModel())
    }
}
