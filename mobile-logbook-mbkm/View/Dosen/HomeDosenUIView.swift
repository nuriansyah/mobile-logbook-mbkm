//
//  HomeDosenUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 17/01/23.
//

import SwiftUI

struct HomeDosenUIView: View {
    @State private var selectedTab: Tabs = .home
    var body: some View {
        TabView(selection: $selectedTab){
                ListMentorshipUIView()
                .tabItem{
                    Image(systemName: "house.fill")
                }
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                }
                ProfileUIView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeDosenUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDosenUIView()
    }
}

enum Tabs {
    case home
    case notification
    case profile
}
 
