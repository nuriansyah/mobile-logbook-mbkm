//
//  DetailReportUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 09/02/23.
//

import SwiftUI

struct DetailReportUIView: View {
    @StateObject var viewModel = CreateCommentViewModel()
    @StateObject var cViewModel = CommentViewModel()
    @StateObject var bViewModel = BimbinganViewModel()
    @State private var showingAlert = false
    
    @State var comment: String = ""
    let report: ReportDetail
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Title   : \(report.title)")
            Text("Content : \(report.content)")
            Text("Commnets")
                .padding(.top)
                .font(.title)
                .fontWeight(.black)
            Spacer()
            ScrollView{
                ForEach(cViewModel.comments, id:\.id){ c in
                    VStack (alignment:.leading,spacing: 2){
                        HStack {
                            if let mhs = c.mhsName{
                                Text(mhs)
                            } else if let dosen = c.dosenName{
                                Text(dosen)
                            }else{
                                Text("Unknows")
                            }
                                
                            Spacer()
                            Text(c.createdAt)
                                .font(.subheadline)
                        }
                        Text(c.comments)
                    }
                    Divider()
                }
            }
            .onAppear{
                cViewModel.getAllComments(postID: 1)
            }
            TextField("Comments...", text: $comment)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.03)))
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black,lineWidth: 1)
                            .overlay {
                                HStack{
                                    Spacer()
                                    Button{
                                        viewModel.createCommentDosen(postID: report.reportID, comment: comment)
                                    } label: {
                                        Image(systemName: "paperplane")
                                            .font(.title2)
                                    }.padding(.trailing)
                                }
                            }
                    }
                }
            if viewModel.errrorMessage != ""{
                Text(viewModel.errrorMessage)
                    .foregroundColor(.red)
            }
            if viewModel.isSuccessful{
                Text("Comment added Successfully")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        bViewModel.approveBimbingan(postId: report.reportID)
                    }) {
                        Label("Accepted", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    Button(action: {
                        bViewModel.rejectedBimbingan(postId: report.reportID)
                    }) {
                        Label("Rejected", systemImage: "xmark.circle.fill")
                        
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                    
                }
            }
        }
        .alert(isPresented: $bViewModel.didApproveBimbingan) {
            Alert(title: Text("Approved Reporting"))
        }
        .alert(isPresented: $bViewModel.didRejectedBimbingan) {
            Alert(title: Text("Rejected Reporting"))
        }
    }
}

struct DetailReportUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailReportUIView(report:ReportDetail(reportID: 0, title: "", content: "", status: "", createdAt: ""))
    }
}


