//
//  CommentView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 28/06/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
    var imageViewModel: ImageViewModel

    var body: some View {
        VStack {
            HStack {
                RoundedImageView(imageViewModel: self.imageViewModel, imageUrl: comment.userImageUrl)
                    .frame(width: 30, height: 25)
                Text("thramos").font(.footnote).fontWeight(.semibold)
                Spacer()
            }
            Text("dasjdk aldjaksldjasdkas djaskldasjdaskldjas djakdl ajdklas jdakld jaksl djadj askdlas jdaksl dajskdl asdjklas djsakld asjkl asdasj djkl adjsakl asdadad sdasdas daadsa ddas dasdadasd adasdas")
                .foregroundColor(.secondary)
                .font(.body)
                .lineLimit(8)
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(id: 1, user_id: 1, post_id: 1, username: "mile_f", userImageUrl: "woman", commentText: "Test"), imageViewModel: ImageViewModel())
    }
}
