//
//  ProfileUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct ProfileUIView: View {
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                HeaderProfileView()
                List {
                    Section {
                        NavigationLink("Change Password") {
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
            }
        }
    }
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView()
    }
}
