//
//  DataKampusMerdekaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct DataKampusMerdekaUIView: View {
    @ObservedObject var viewModel: MahasiswaDetailViewModel
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                VStack {
                    if isEditing {
                        editView
                    } else {
                        notEditView
                    }
                    
                    Button(isEditing ? "Simpan" : "Edit") {
                        if isEditing {
                            viewModel.editDetailMahasiswa()
                        }
                        isEditing.toggle()
                    }
                    
                }
                
            }
        }.navigationTitle("Data Kampus Merdeka")
    }
}

struct DataKampusMerdekaUIView_Previews: PreviewProvider {
    static var previews: some View {
        DataKampusMerdekaUIView(viewModel: MahasiswaDetailViewModel(mahasiswa: Mahasiswa(id: 0, company: "", programKM: "", learnPath: "", batch: 0)))
        
    }
}

extension DataKampusMerdekaUIView{
    private var editView: some View{
        VStack(alignment: .leading) {
            Section {
                TextField("Input Your Kampus Merdeka Program", text: $viewModel.mahasiswa.programKM)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            } header: {
                Text("Kampus Merdeka Program")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                TextField("Input Your Company", text: $viewModel.mahasiswa.company)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            }header: {
                Text("Company")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                TextField("Input Your Program", text: $viewModel.mahasiswa.learnPath)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            }header: {
                Text("Program")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                TextField("Input Your Batch", text: Binding(
                    get: { String(viewModel.mahasiswa.batch) },
                    set: { viewModel.mahasiswa.batch = Int($0)
                        ?? 0 }
                ))
                .padding(10)
                .background(Color.black.opacity(0.04))
                .cornerRadius(8)
            }header: {
                    Text("Batch")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
        }
    }//:MARK editView
    
    
    private var notEditView: some View{
        VStack(alignment: .leading){
            Section {
                Text("\(viewModel.mahasiswa.programKM)")
                    .frame(width: 300)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
                    
            } header: {
                Text("Kampus Merdeka Program")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                Text("\(viewModel.mahasiswa.company)")
                    .frame(width: 300)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            } header: {
                Text("Company")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                Text("\(viewModel.mahasiswa.learnPath)")
                    .frame(width: 300)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            } header: {
                Text("Program")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
            Section {
                Text("\(viewModel.mahasiswa.batch)")
                    .frame(width: 300,alignment: .leading)
                    .padding(10)
                    .background(Color.black.opacity(0.04))
                    .cornerRadius(8)
            } header: {
                Text("Batch")
                    .font(.caption.bold())
                    .foregroundColor(.black)
            }
        }
    }//:MARKnotEditView
    
}
