//
//  HomeMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct HomeMahasiswaUIView: View {
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeContentUIView(notificationCount: 24)
                .tabItem{
                    Image(systemName: "house.fill")
                }
            ListReportingMahasiswaUIView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                }
            MahasiswaNotificationUIView()
                .tabItem {
                    Image(systemName: "bell")
                }
            
            ProfileMahasiswaUIView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

struct HomeMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMahasiswaUIView()
    }
}

