//
//  AddReportUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct AddReportUIView: View {
    @State private var judul: String = ""
    @State private var date = Date()
    var body: some View {
        
        VStack(alignment: .leading,spacing: 5) {
            DatePicker("Pick a Date", selection: $date, in: Date().addingTimeInterval(-846000)...Date(), displayedComponents: [.date])
            Text("Title")
            TextField("title..", text: $judul)
                .padding(.vertical,5)
                .padding(.horizontal,5)
                .overlay {
                    RoundedRectangle(cornerRadius: 6).stroke(.black,lineWidth: 2)
                }
            
            Text("Fill your Report")
                .font(.system(.subheadline).bold())
            TextField("Reportings yours..", text: $judul,axis: .vertical)
                .padding([.horizontal,.vertical])
                .lineLimit(8, reservesSpace: true)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black,lineWidth: 2)
                })
            Button(action: {
                print("get the all data")
            }) {
                Spacer()
                HStack{
                    Text("Accept Reporting")
                }
                .frame(minWidth: 0,maxWidth: 200)
                .padding()
                .foregroundColor(.black)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 2)
                        
                }
                Spacer()
            }
            .padding([.horizontal,.top])
                
        }.padding([.vertical,.horizontal])
        
        

    }
}

struct AddReportUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddReportUIView()
    }
}
