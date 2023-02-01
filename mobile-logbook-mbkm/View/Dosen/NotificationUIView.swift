//
//  NotificationUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct NotificationUIView: View {
    let notification = [
        "Anggra telah membuat reporting bimbimngan",
        "Nanda telah membuat reporting bimbingan",
        "Greesel telah membuat reporting bimbingan",
        "Ashel Telah membuat reporting bimbingan",
        "Dandung telah membuat reporting bimbingan"
    ]
    var body: some View {
        VStack{
            List {
                ForEach(notification, id:\.self) { notif in
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
    }
}

struct NotificationUIView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationUIView()
    }
}
