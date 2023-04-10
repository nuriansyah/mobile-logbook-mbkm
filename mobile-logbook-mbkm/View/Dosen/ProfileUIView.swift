//
//  ProfileUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct ProfileUIView: View {
    @State var notificationsEnabled: Bool = false
    @ObservedObject var dosen = DosenViewModel()
    @EnvironmentObject var settings: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                headerProfile
                ZStack{
                    Text("Change Password")
                    List {
                        Section {
                            NavigationLink("Change Password") {
                                ChangePasswordMahasiswaUIView()
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
    private var headerProfile: some View{
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    if dosen.dosen != nil {
                        Text("\(dosen.dosen!.name)")
                        Text("\(dosen.dosen!.email)")
                    } else {
                        Text("Loading")
                    }
                }
                .onAppear{
                    dosen.fetchUser()
                }
            }.padding(.leading)
        }
    }
    
    private var logoutBtn: some View {
        HStack{
            Spacer()
            VStack{
                Spacer()
                    .hidden()
                
                Button(action:{
                    settings.signout()
                    navigateToLogin()
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
    
    private func navigateToLogin() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: SelectLoginUIView().environmentObject(LoginViewModel()))
            window.makeKeyAndVisible()
        }
    }
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView()
    }
}
