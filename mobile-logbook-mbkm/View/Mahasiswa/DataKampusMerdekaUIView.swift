//
//  DataKampusMerdekaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct DataKampusMerdekaUIView: View {
    @State var kampusMerdekaProgram: String = ""
    @State var company: String = ""
    @State var program: String = ""
    @State var batch: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Input Your Kampus Merdeka Program", text: $kampusMerdekaProgram)
                } header: {
                    Text("Kampus Merdeka Program")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                Section {
                    TextField("Input Your Company", text: $company)
                }header: {
                    Text("Company")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                Section {
                    TextField("Input Your Program", text: $program)
                }header: {
                    Text("Program")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                Section {
                    TextField("Input Your Batch", text: $batch)
                }header: {
                    Text("Batch")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                Section {
                    
                } footer: {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Save!")
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

struct DataKampusMerdekaUIView_Previews: PreviewProvider {
    static var previews: some View {
        DataKampusMerdekaUIView()
    }
}
