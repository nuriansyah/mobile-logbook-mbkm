//
//  mobile_logbook_mbkmApp.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 17/01/23.
//

import SwiftUI

@main
struct mobile_logbook_mbkmApp: App {
    let loginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            SelectLoginUIView()
                .environmentObject(loginViewModel)
        }
    }
}
