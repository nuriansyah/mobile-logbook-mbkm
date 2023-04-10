//
//  ContentView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 17/01/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    var body: some View {
        VStack(spacing: 20) {
            if loginViewModel.isAuthenticated {
                Text("Welcome Home!")
                Button(action: {
                    loginViewModel.signout()
                }) {
                    Text("Logout")
                }
            } else {
                TextField("NRP", text: $loginViewModel.nrp)
                SecureField("Password", text: $loginViewModel.password)
                Button(action: {
                    loginViewModel.loginMahasiswa()
                }) {
                    Text("Login")
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
