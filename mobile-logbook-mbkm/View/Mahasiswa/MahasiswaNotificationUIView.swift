//
//  MahasiswaNotificationUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 21/02/23.
//

import SwiftUI

struct MahasiswaNotificationUIView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let notificationMhs = [
        "Dosen Pendamping telah mengecek laporan anda",
        "Dosen Pendamping telah menolak laporan anda",
        "Dosen Pendamping telah menerima laporan anda",
        "Dosen Pendamping telah menerima laporan anda",
        "Dosen Pendamping telah menerima laporan anda",
        "Dosen Pendamping telah menolak laporan anda"
    ]
    var body: some View {
        VStack{
            List {
                ForEach(notificationMhs, id:\.self) { notif in
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.caption)
                        VStack(alignment: .leading) {
                            Text(notif)
                                .font(.subheadline)
                        }
                    }
                }
            }.accessibilityElement().listStyle(.grouped)
        }
        .navigationBarTitle(Text("Notifications"), displayMode: .inline)
    }
}

struct MahasiswaNotificationUIView_Previews: PreviewProvider {
    static var previews: some View {
        MahasiswaNotificationUIView()
    }
}

