//
//  ListReportingMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 04/03/23.
//

import SwiftUI

struct ListReportingMahasiswaUIView: View {
    @StateObject private var viewModel = ReportsListViewModel()
    var body: some View {
        NavigationView {
            VStack{
                List {
                    listApproved
                    listPending
                    listReject
                }
            }
        }
    }
}

struct ListReportingMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListReportingMahasiswaUIView()
    }
}

extension ListReportingMahasiswaUIView{
    private var listApproved: some View{
        Section {
            ForEach(viewModel.reportsApproved) { report in
                VStack(alignment: .leading,spacing: 10) {
                    HStack {
                        Text("\(report.title)")
                        Spacer()
                        Text("\(report.createdAt)")
                    }
                    Text("\(report.content)")
                        .font(.body.smallCaps())
                }
            }
        } header: {
            HStack{
                Image(systemName: "doc.plaintext")
                Text("Approved  (\(viewModel.countApproved))")
            }.foregroundColor(.green)
        }
        .onAppear{
            viewModel.getApprovedReports()
        }
    }
    private var listPending: some View{
        Section {
            ForEach(viewModel.reportsPending.indices, id: \.self) { index in
                let report = viewModel.reportsPending[index]
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(report.title)
                        Spacer()
                        Text(report.created_at)
                    }
                    Text(report.content)
                        .font(.body.smallCaps())
                }
            }

        } header: {
            HStack{
                Image(systemName: "doc.plaintext")
                Text("Pending (\(viewModel.countPending))") // update countPending
            }.foregroundColor(.orange)
        }
        .onAppear {
            viewModel.getPendingReports()
        }
    }


    private var listReject: some View{
        Section {
            List(viewModel.reportsReject, id: \.id) { report in
                VStack(alignment: .leading,spacing: 10) {
                    HStack {
                        Text("\(report.title)")
                        Spacer()
                        Text("\(report.createdAt)")
                    }
                    Text("\(report.content)")
                        .font(.body.smallCaps())
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Edit!")
                                .fontWeight(.semibold)
                                .font(.callout)
                            
                        }
                        .frame(width: 80)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.blue.opacity(0.8))
                        .cornerRadius(14)
                        .padding([.trailing])
                        Spacer()
                    }
                }
            }
        }header: {
            HStack{
                Image(systemName: "doc.plaintext")
                Text("Reject  (\(viewModel.countRejected))")
            }.foregroundColor(.red)
        }
        .onAppear {
            viewModel.getRejectedReports()
        }
    }
}
