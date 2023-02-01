//
//  ListMentorshipUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 17/01/23.
//

import SwiftUI

struct ListMentorshipUIView: View {
    let mhs = [
        "John",
        "Alice",
        "Bob",
        "Foo",
        "Bar"
    ]
    let reqMhs = [
        "Nanda",
        "Ninda",
        "Rando",
        "Bob",
        "Ingga"
    ]
    var body: some View {
        
            NavigationView {
                VStack(alignment: .leading, spacing: 0){
                HeaderProfileView()
                List {
                    Section {
                        ForEach(mhs, id:\.self){ mhs in
                            NavigationLink(mhs) {
                                Text("Halaman Detail")
                            }
                        }
                    }header: {
                        Text("List Mahasiswa")
                    }
                    Section {
                        ForEach(reqMhs, id:\.self){ mhs in
                            HStack {
                                Text(mhs)
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                }
                                .padding(.trailing)
                                Button {
                                    
                                } label: {
                                    Image(systemName: "person.crop.circle.fill.badge.xmark").foregroundColor(.red)
                                        .font(.title2)
                                }
                                .padding(.trailing)
                            }
                        }
                    }header: {
                        Text("List Request Mahasiswa")
                    }
                }.listStyle(.insetGrouped)
            }
        }
    }
}

struct ListMentorshipUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListMentorshipUIView()
    }
}

struct HeaderProfileView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    Text("Nama Dosen")
                    Text("Dosen Pembimbing")
                }
            }.padding(.leading)
        }
    }
}
