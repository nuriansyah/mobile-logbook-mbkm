//
//  DetailReportingUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI


struct DetailReportingUIView: View {
    @StateObject var cViewModel = CommentViewModel()
    @StateObject var viewModel = CreateCommentViewModel()
    
    @State private var showSuccessAlert = false
    
    @State var isEditing = false
    @State var comment: String = ""
    @State var report: Report
    
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
                cViewModel.getAllComments(postID: report.id!)
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
                                        viewModel.createCommentMahasiswa(postID: report.id!, comment: comment)
                                        self.showSuccessAlert.toggle()
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
        }
        .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if report.status != "Accepted" {
                        Button(action: {
                            self.isEditing = true
                        }) {
                            Image(systemName: "pencil")
                                .font(.title2)
                        }
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditReportingUIView(report: $report, reportViewModel: ReportViewModel(report: report))
            }
            .alert(isPresented: $showSuccessAlert, content: {
                Alert(title: Text("Success"), message: Text("Comment added successfully."), dismissButton: .default(Text("OK")))
            })
    }
}

struct DetailReportingUIView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleReport = Report(id: 1, title: "Sample Report", content: "This is a sample report", type: "Type A", status: "Approved", dosen_id: 1, status_id: 1, created_at: "2022-01-01", message: "This is a sample message")
        return DetailReportingUIView(report: sampleReport)
    }
}

