//
//  ProfileUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct ProfileUIView: View {
    @StateObject private var loginVM = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                headerProfile
                ZStack{
                    List {
                        Section {
                            NavigationLink(destination: ChangePasswordDosenUIView()) {
                                Text("Change Password")
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
        }
    }
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView()
    }
}
extension ProfileUIView{
    private var headerProfile: some View{
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    Text("Nama Dosen")
                    Text("Email Dosen")
                }
            }.padding(.leading)
        }
    }
    private var logoutBtn: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
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
