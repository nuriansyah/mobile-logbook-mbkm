//
//  DetailReportingUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI
import UserNotificationsUI

struct DetailReportingUIView: View {
        @State var text: String = ""
        let report: Report
        var body: some View {
            VStack(alignment:.leading){
                Text("Title   : \(report.title)")
                Text("Content : \(report.content)")
                Text("Commnets")
                    .padding(.top)
                    .font(.title)
                    .fontWeight(.black)
                Spacer()
                ScrollView {
                    VStack(alignment: .leading,spacing: 1){
                        Section{
                            Text("Author")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom,5)
                            Text("Kekurangan")
                            Divider()
                                .padding(.vertical)
                            Text("Replied")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom,5)
                            Text("Kekurangan")
                            Divider()
                                .padding(.vertical)
                            
                        }
                    }
                }
                TextField("Comments...", text: $text)
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
                                            
                                        } label: {
                                            Image(systemName: "paperplane")
                                                .font(.title2)
                                        }.padding(.trailing)
                                    }
                                }
                        }
                    }
            }
            .padding()
        }
}

struct DetailReportingUIView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleReport = Report(id: 1, title: "Sample Report", content: "This is a sample report", type: "Type A", status: "Approved", dosen_id: 1, status_id: 1, created_at: "2022-01-01", message: "This is a sample message")
        return DetailReportingUIView(report: sampleReport)
    }
}
