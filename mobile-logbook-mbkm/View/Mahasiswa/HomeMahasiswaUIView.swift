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
            HomeContentUIView()
                .tabItem{
                    Image(systemName: "house.fill")
                }
            AddReportUIView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
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

