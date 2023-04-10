//
//  DataKampusMerdekaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI

struct DataKampusMerdekaUIView: View {
    @ObservedObject var viewModel = UserViewModel()

    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                view
            }
        }.navigationTitle("Data Kampus Merdeka")
    }
}

struct DataKampusMerdekaUIView_Previews: PreviewProvider {
    static var previews: some View {
        DataKampusMerdekaUIView()
        
    }
}


extension DataKampusMerdekaUIView{
    private var view: some View{
        VStack(alignment: .leading){
            if let mahasiswa = viewModel.user{
                Section {
                    Text("\(mahasiswa.learn_path)")
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
                    Text("\(mahasiswa.company)")
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
                    Text("\(mahasiswa.learn_path)")
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
                    Text("\(mahasiswa.batch)")
                        .frame(width: 300,alignment: .leading)
                        .padding(10)
                        .background(Color.black.opacity(0.04))
                        .cornerRadius(8)
                } header: {
                    Text("Batch")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
            }else{
                Text("Fetching Data...")
            }
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }//:MARKnotEditView
    
}
