//
//  EditReportingUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct EditReportingUIView: View {
    @Binding var report: Report
    @ObservedObject var reportViewModel: ReportViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlertSuccess = false
    @State private var showAlertError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $report.title)
                        .autocorrectionDisabled()
                }
                Section(header: Text("Content")) {
                    TextField("Content", text: $report.content,axis: .vertical)
                        .lineLimit(8, reservesSpace: true)
                        .frame(width: 200,height: 200)
                        .autocorrectionDisabled()
                }
            }
            .navigationBarTitle("Edit Report")
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        if report.title.isEmpty || report.content.isEmpty{
                            self.showAlertError.toggle()
                        } else {
                            reportViewModel.editReport(title: report.title, content: report.content) { result in
                                switch result {
                                case .success:
                                    self.showAlertSuccess.toggle()
                                case .failure(let error):
                                    print(error)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }) {
                        Text("Save")
                    }
            )
            .alert(isPresented: $showAlertError, content: {
                           Alert(title: Text("Failed"), message: Text("Title Or Content Cannot Empty"), dismissButton: .default(Text("OK")))
            })
            .background(
                EmptyView()
                .alert(isPresented: $showAlertSuccess, content: {
                    Alert(title: Text("Success"), message: Text("Report updated successfully."), dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    })
                })
            )
        }
    }
}



struct EditReportingUIView_Previews: PreviewProvider {
    static var previews: some View {
        let report = Report(id: 1, title: "Sample Report", content: "This is a sample report", type: "Type A", status: "Approved", dosen_id: 1, status_id: 1, created_at: "2022-01-01", message: "This is a sample message")
        EditReportingUIView(report: .constant(report), reportViewModel: ReportViewModel(report: report))
    }
}

