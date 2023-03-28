//
//  ListMentorshipUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 17/01/23.
//

import SwiftUI

struct ListMentorshipUIView: View {
    
    @ObservedObject var updtViewModel = UpdateBimbinganViewModel()
    @ObservedObject var dsnViewModel = DosenViewModel()
    @ObservedObject var dViewModel = ListReportViewModel()
    @ObservedObject var bViewModel = ListRequestPendampingViewModel()
    
    var body: some View {
       NavigationView {
            VStack(alignment: .leading, spacing: 0){
                headerProfile
                List {
                    listMahasiswa
                    requestKonversiNilai
                }.listStyle(.insetGrouped)
            }
        }
    }
}

struct ListMentorshipUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListMentorshipUIView()
    }
}



extension ListMentorshipUIView{
    private var listMahasiswa: some View {
        Section(header: Text("List Mahasiswa")){
            ForEach(dViewModel.mahasiswas, id: \.id) { mahasiswa in
                NavigationLink(destination: DetailMahasiswaUIView(user: mahasiswa)) {
                    VStack(alignment: .leading) {
                        Text(mahasiswa.name)
                            .font(.headline)
                        Text(mahasiswa.nrp)
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.2))
                    }
                }
            }
        }
        .onAppear {
            dViewModel.fetchMahasiswaByDsn { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }//MARK: ListMahasiswa
    
    private var requestMahasiswa: some View{
        Section {
            ForEach(bViewModel.reports){ mhs in
                HStack {
                    Text(mhs.name)
                    Spacer()
                    Button(action: {
                        self.updtViewModel.updateBimbingan(mahasiswaID: mhs.id) { result in
                            switch result {
                            case .success(let status):
                                // show success message
                                DispatchQueue.main.async {
                                    self.updtViewModel.bimbinganStatus = .accepted
                                    print("Success: \(status)")
                                    
                                }
                                break
                            case .failure(let error):
                                // show error message
                                self.updtViewModel.bimbinganStatus = .pending
                                print("Error: \(error.message)")
                                break
                            }
                        }
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.xmark").foregroundColor(.red)
                            .font(.title2)
                    }
                    .padding(.trailing)
                }
            }
        }header: {
            Text("List Request Mahasiswa")
        }
        .onAppear {
            self.bViewModel.fetchReports { (result: Result<[Bimbingan], Error>) in
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.bViewModel.reports = users
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }//MARK: RequestMahasiswa
    private var headerProfile: some View{
        VStack(alignment: .leading, spacing: 0) {
            if dsnViewModel.dosen != nil{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .padding()
                    VStack(alignment: .leading){
                        Text(dsnViewModel.dosen!.name)
                            .font(.title)
                        Text(dsnViewModel.dosen!.email)
                            .font(.footnote)
                            .foregroundColor(.black.opacity(0.2))
                    }
                }.padding(.leading)
            }else{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .padding()
                    VStack(alignment: .leading){
                        Text("Nama Dosen")
                            .font(.title)
                        Text("Email Dosen")
                            .font(.footnote)
                            .foregroundColor(.black.opacity(0.2))
                    }
                }.padding(.leading)
            }
        }.onAppear{
            dsnViewModel.fetchUser()
        }
    }
    private var requestKonversiNilai: some View{
        Section{
            VStack(alignment:.leading,spacing:0){
                HStack {
                    Text("Gendis")
                    Spacer()
                    VStack {
                        Button(action:{
                            
                        }){
                            Image(systemName: "arrow.down.doc")
                                .font(.title2)
                            Text("Download")
                                .font(.footnote)
                        }
                    }.padding(.trailing)
                }
            }
        }header:{
            Text("List Request konversi nilai")
        }
    }
}
