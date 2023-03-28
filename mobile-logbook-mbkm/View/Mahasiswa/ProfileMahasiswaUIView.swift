//
//  ProfileMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct ProfileMahasiswaUIView: View {
    @State var notificationsEnabled: Bool = false
    @State var isShowingSelectionDosenSheet = false
    @ObservedObject var userViewModel = UserViewModel()
    @StateObject private var loginVM = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                headerViewSome
                ZStack{
                    Text("Change Password")
                    List {
                        Section {
                            NavigationLink("Change Password") {
                                ChangePasswordMahasiswaUIView()
                            }
                            NavigationLink("Data Kampus Merdeka") {
                                DataKampusMerdekaUIView(viewModel: MahasiswaDetailViewModel(mahasiswa: Mahasiswa(id: 0, company: "", programKM: "", learnPath: "", batch: 0)))
                            }
                            NavigationLink("Upload File Konversi Nilai") {
                                UploadLaporanUIView()
                            }
                            Toggle(isOn: $notificationsEnabled) {
                                Text("Enabled Notifications")
                            }
                        } header: {
                            Text("Profile")
                        }
                        Section {
                            NavigationLink("This Apps") {
                                Text("Version Apps 0.0.1")
                            }
                        } header: {
                            Text("About")
                        }
                    }.listStyle(.insetGrouped)
                    logoutBtn
                }
            }
            .onChange(of: loginVM.isAuthenticated) { isAuthenticated in
                if !isAuthenticated {
                    loginVM.nrp = ""
                    loginVM.password = ""
                }
            }
        }
    }
}

struct ProfileMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMahasiswaUIView()
    }
}

extension ProfileMahasiswaUIView{
    private var headerViewSome: some View{
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    if userViewModel.user != nil {
                        Text("\(userViewModel.user!.nama)")
                        Text("\(userViewModel.user!.nrp)")
                    }else{
                        Text("Loading")
                    }
                }
                .onAppear{
                    userViewModel.fetchUser()
                }
            }.padding(.leading)
        }
    }
    private var logoutBtn: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
                NavigationLink(destination: LoginMahasiswaUIView(), isActive: $loginVM.isAuthenticated) {
                    EmptyView()
                }
                .hidden()

                Button(action:{
                    loginVM.signout()
                }){
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(15)
                }
            }
            Spacer()
        }
    }
}
