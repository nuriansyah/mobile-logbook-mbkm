//
//  SelectLoginUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 27/01/23.
//

import SwiftUI

struct SelectLoginUIView: View {
    @ObservedObject var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack{
                Image("welcome-select")
                    .resizable()
                    .scaledToFit()
                Text("Login Sebagai")
                    .font(.title2.bold().monospaced().smallCaps())
                HStack{
                    if loginViewModel.isAuthenticated{
                        HomeDosenUIView()
                    }else{
                        NavigationLink{
                            LoginUIView()
                        } label: {
                            Text("Dosen")
                                .fontWeight(.semibold)
                                .font(.title2.smallCaps())
                        }
                        .frame(width: 120)
                        .padding(6)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                    
                    if loginViewModel.isAuthenticated{
                        HomeMahasiswaUIView()
                    }else{
                        NavigationLink{
                            LoginMahasiswaUIView()
                        } label: {
                            Text("Mahasiswa")
                                .fontWeight(.semibold)
                                .font(.title2.smallCaps())
                        }
                        .frame(width: 120)
                        .padding(6)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                }
                
            }
        }
    }
}

struct SelectLoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLoginUIView()
    }
}
