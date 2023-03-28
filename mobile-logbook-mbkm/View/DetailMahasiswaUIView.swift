//
//  DetailMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 08/02/23.
//

import SwiftUI

struct DetailMahasiswaUIView: View {
    let user: MahasiswaDetail
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack{
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 120))
                    //            Text("\(user.id)").hidden()
                    Text(user.name)
                        .font(.title2.smallCaps())
                    Text(user.nrp)
                        .font(.title2.uppercaseSmallCaps())
                }.padding([.leading,.vertical])
                VStack(alignment: .leading,spacing: 10){
                    Text("Company : \(user.company)")
                    Text("Program : \(user.programKM)")
                    Text("Learning Path : \((user.learnPath))")
                        .multilineTextAlignment(.leading)
                    Text("Batch : \(user.batch)")
                }.padding(.bottom,30)
            }
            .padding(.bottom)
            Section(header: Text("List Bimbingan").font(.subheadline).fontWeight(.medium)) {
                if !user.reportDetails.isEmpty{
                    List(user.reportDetails, id: \.reportID){ report in
                        HStack{
                            VStack(alignment:.listRowSeparatorLeading){
                                Text("\(report.title)")
                                    .font(.headline)
                                Text("\(report.content)")
                            }
                            Spacer()
                            NavigationLink(destination: DetailReportUIView(report: report)){
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                else{
                    Text("No reports available.")
                        .font(.subheadline)
                }
            }
            .padding(.leading)
        }
    }
}





struct DetailMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMahasiswaUIView(user: MahasiswaDetail(id: 0, name: "", nrp: "", company: "", programKM: "", learnPath: "", batch: 0, reportDetails: [ReportDetail(reportID: 0, title: "Title", content: "Content",status: "",createdAt: "")]))
    }
}

