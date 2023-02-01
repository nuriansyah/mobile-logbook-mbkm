//
//  HomeContentUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct HomeContentUIView: View {
    @State private var isSHowingDetailSheet: Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: 0) {
                    ZStack{
                        headerView
                    }
                    
                Text("My Activity")
                    .font(.title2.bold())
                    .padding(.leading)
               listActivity
                
               btnAddReport
                    .onTapGesture {
                        isSHowingDetailSheet.toggle()
                    }
                    .sheet(isPresented: $isSHowingDetailSheet) {
                        VStack{
                            AddReportUIView()
                                .presentationDetents([.medium, .large])
                            
                                .presentationDragIndicator(.visible)
                        }
                        .padding()
                    }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct HomeContentUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentUIView()
    }
}

extension HomeContentUIView{
    private var headerView: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: .infinity,height: 180)
                .foregroundColor(.clear)
                .overlay {
                    Color.teal.opacity(0.2)
                }
            VStack(alignment:.leading,spacing: 0) {
                HStack{
                    Text("Hallo, Fitra Ananda")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "bell")
                        .font(.headline)
                        .padding(.trailing)
                }.padding(.bottom)
                Text("Magang Bersertifikat Kampus Merdeka")
                    .font(.subheadline)
                Text("Ruang Guru")
                    .font(.subheadline)
                Text("Dos Pem: Dosen Pendamping 1")
                    .font(.subheadline)
            }.padding([.horizontal,.top])
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }//:MARK HeadeView
    
    private var listActivity: some View{
        List {
            VStack(alignment: .leading){
                HStack{
                    Circle()
                        .frame(width: 10,height: 20)
                    Text("Reporting")
                    Spacer()
                    Text(Date.now, format:.dateTime.day().month().year())
                        .padding(.trailing)
                }
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity,maxHeight: 80)
                        .foregroundColor(.teal.opacity(0.2))
                    Text("Judul")
                        .font(.title3.bold())
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                    VStack{
                        HStack {
                            Text("status : ")
                                .font(.headline)
                                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                            Text("Accepted")
                                .font(.subheadline.bold())
                                .foregroundColor(.green)
                                .padding(.top,40)
                            Spacer()
                            Button {
                                
                            } label: {
                                    Text("detail")
                                        .fontWeight(.semibold)
                                        .font(.callout)
                                 
                            }
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.blue.opacity(0.8))
                            .cornerRadius(14)
                            .padding([.trailing,.top])
                        }
                    }
                }
            }
            HStack{
                Circle()
                    .frame(width: 10,height: 20)
                Text("Reporting")
                Spacer()
                Text(Date.now, format:.dateTime.day().month().year())
                    .padding(.trailing)
            }
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity,maxHeight: 80)
                    .foregroundColor(.teal.opacity(0.2))
                Text("Judul")
                    .font(.title3.bold())
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                VStack{
                    HStack {
                        Text("status : ")
                            .font(.headline)
                            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                        Text("Pending")
                            .font(.subheadline.bold())
                            .foregroundColor(.orange)
                            .padding(.top,40)
                        Spacer()
                        Button {
                            
                        } label: {
                                Text("detail")
                                    .fontWeight(.semibold)
                                    .font(.callout)
                             
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.blue.opacity(0.8))
                        .cornerRadius(14)
                        .padding([.trailing,.top])
                    }
                }
            }
            HStack{
                Circle()
                    .frame(width: 10,height: 20)
                Text("Reporting")
                Spacer()
                Text(Date.now, format:.dateTime.day().month().year())
                    .padding(.trailing)
            }
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity,maxHeight: 80)
                    .foregroundColor(.teal.opacity(0.2))
                Text("Judul")
                    .font(.title3.bold())
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                VStack{
                    HStack {
                        Text("status : ")
                            .font(.headline)
                            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                        Text("Revision")
                            .font(.subheadline.bold())
                            .foregroundColor(.red)
                            .padding(.top,40)
                        Spacer()
                        Button {
                            
                        } label: {
                                Text("detail")
                                    .fontWeight(.semibold)
                                    .font(.callout)
                             
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.blue.opacity(0.8))
                        .cornerRadius(14)
                        .padding([.trailing,.top])
                    }
                }
            }
        }.listStyle(.plain)
    }//:MARK listActivity
    
    private var btnAddReport: some View{
        HStack{
            Spacer()
            Color.primary
                .frame(width: 60, height: 40)
                .clipShape(Circle())
                .opacity(0.6)
                .overlay{
                    Image(systemName: "plus.circle.fill"
                          )
                    .font(.title)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .padding(10)
                }
        }.padding([.trailing,.bottom])
    }
    
}

