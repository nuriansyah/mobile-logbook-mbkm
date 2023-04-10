//
//  MahasiswaNotificationUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 21/02/23.
//

import SwiftUI
import UserNotifications

struct MahasiswaNotificationUIView: View {
    @StateObject var loginVM = LoginViewModel()
        
        var body: some View {
            NavigationView {
                VStack {
                    if loginVM.isAuthenticated {
                        Text("Welcome!")
                        Button(action: {
                            loginVM.signout()
                        }) {
                            Text("Logout")
                        }
                    } else {
                        Text("Hello")
                    }
                }
                .navigationTitle("Home")
            }
        }
}

struct MahasiswaNotificationUIView_Previews: PreviewProvider {
    static var previews: some View {
        MahasiswaNotificationUIView()
    }
}

