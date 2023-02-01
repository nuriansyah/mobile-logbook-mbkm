//
//  EditReportingUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct EditReportingUIView: View {
    @State private var judul: String = ""
    @State var dateOfBirth: Date = Date()
    @State private var datePickerId: Int = 0
    
    private var dateOfBirthRange: ClosedRange<Date> {
        let dateFrom = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        let dateTo: Date = Date()
        return dateFrom...dateTo
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            Form {
                Section{
                    DatePicker(
                        "",
                        selection: $dateOfBirth,
                        in: dateOfBirthRange,
                        displayedComponents: .date
                    )
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .id(datePickerId)
                    
                    VStack(alignment: .leading,spacing: 10){
                        Text("Title")
                        TextField("Title..", text: $judul)
                            .padding(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 2)
                            }
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
                }.listRowSeparator(.hidden)
                Section {
                    
                } footer: {
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
        }
    }
}

struct EditReportingUIView_Previews: PreviewProvider {
    static var previews: some View {
        EditReportingUIView()
    }
}
