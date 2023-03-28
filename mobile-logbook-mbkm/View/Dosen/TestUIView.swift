//
//  TestUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 27/03/23.
//

import SwiftUI

struct TestUIView: View {
    @StateObject var viewModel = CommentViewModel()
        let postID = 1 // Ganti dengan postID yang ingin diambil
        
        var body: some View {
            VStack {
                if !viewModel.comments.isEmpty {
                    List(viewModel.comments, id: \.id) { comment in
//                        VStack(alignment: .leading) {
//                            Text(comment.dosenName)
//                                .font(.headline)
//                            Text(comment.comment)
//                                .font(.body)
//                            Text(comment.createdAt)
//                                .font(.footnote)
//                        }
                    }
                } else {
                    if !viewModel.errorMessage.isEmpty {
                        Text("Error: \(viewModel.errorMessage)")
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear {
                viewModel.fetchComments(postID: postID)
            }
        }
}

struct TestUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestUIView()
    }
}
