//
//  ProfileMahasiswaUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct ProfileMahasiswaUIView: View {
    @State var notificationsEnabled: Bool = false
    @ObservedObject var userViewModel = UserViewModel()
    @EnvironmentObject var settings: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0){
                headerViewSome
                ZStack{
                    Text("Change Password")
                    List {
                        Section {
                            NavigationLink("Change Password") {
                                ChangePasswordMahasiswaUIView()
                            }
                            NavigationLink("Data Kampus Merdeka") {
                                DataKampusMerdekaUIView()
                            }
                            NavigationLink("Upload File Konversi Nilai") {
                                UploadKonversiNilaiUIView()
                            }
                            Toggle(isOn: $notificationsEnabled) {
                                Text("Toggle Notifications")
                            }.onChange(of: notificationsEnabled) { enabled in
                                if enabled {
                                    requestNotificationPermission()
                                } else {
                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                }
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
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success {
                notificationsEnabled = true
                scheduleNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder: Counseling/Mentoring Report"
        content.subtitle = "Don't forget to submit your report!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.day = 5
        
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Notifikasi berhasil ditetapkan")
            }
        }
    }
    
    private var headerViewSome: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    if userViewModel.user != nil {
                        Text("\(userViewModel.user!.nama)")
                        Text("\(userViewModel.user!.nrp)")
                    } else {
                        Text("Loading")
                    }
                }
                .onAppear{
                    userViewModel.fetchUser()
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

struct ProfileMahasiswaUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMahasiswaUIView()
    }
}

