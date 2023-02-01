//
//  DetailReportingUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 20/01/23.
//

import SwiftUI
import UserNotificationsUI

struct DetailReportingUIView: View {
   
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Section {
                        VStack(alignment: .leading,spacing: 10) {
                            HStack {
                                Text("Judul")
                                Spacer()
                                Text("14/02/2023")
                            }
                            Text("Content Report")
                                .font(.body.smallCaps())
                        }
                    } header: {
                        HStack{
                            Image(systemName: "doc.plaintext")
                            Text("Approved (2)")
                        }.foregroundColor(.green)
                    }
                    Section {
                        VStack(alignment: .leading,spacing: 10) {
                            HStack {
                                Text("Judul")
                                Spacer()
                                Text("14/02/2023")
                            }
                            Text("Content Report")
                                .font(.body.smallCaps())
                        }
                    }header: {
                        HStack{
                            Image(systemName: "doc.plaintext")
                            Text("Pending (5)")
                        }.foregroundColor(.orange)
                    }
                    Section {
                        VStack(alignment: .leading,spacing: 10) {
                            HStack {
                                Text("Judul")
                                Spacer()
                                Text("14/02/2023")
                            }
                            Text("Content Report")
                                .font(.body.smallCaps())
                            HStack {
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("Edit!")
                                        .fontWeight(.semibold)
                                        .font(.callout)
                                    
                                }
                                .frame(width: 80)
                                .padding(10)
                                .foregroundColor(.white)
                                .background(.blue.opacity(0.8))
                                .cornerRadius(14)
                            .padding([.trailing])
                                Spacer()
                            }
                            
                            
                        }
                    }header: {
                        HStack{
                            Image(systemName: "doc.plaintext")
                            Text("Reject (12)")
                        }.foregroundColor(.red)
                    }
                }
            }
        }

    }
}

struct DetailReportingUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailReportingUIView()
    }
}
