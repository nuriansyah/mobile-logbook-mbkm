//
//  HomeContentUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 19/01/23.
//

import SwiftUI

struct HomeContentUIView: View {
    
    @State var isShowingAddReportSheet = false
    @State var isShowingUploadFileSheet = false
    @StateObject var userViewModel = UserViewModel()
    @StateObject var reportViewModel = ListReportViewModel()
    
    @State var notificationCount: Int
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading,spacing: 0) {
                ZStack{
                    headerView
                }
                Text("My Activity")
                    .font(.title2.bold())
                    .padding(.leading)
                ZStack{
                    listActivity
                    VStack {
                        Spacer(minLength: 20)
                        HStack{
                            Spacer()
                            menuPopUp
                                .padding()
                                .sheet(isPresented: $isShowingAddReportSheet) {
                                    VStack{
                                        AddReportUIView()
                                            .presentationDetents([.medium, .medium])
                                            .presentationDragIndicator(.visible)
                                    }
                                    .padding()
                                }
                                .sheet(isPresented: $isShowingUploadFileSheet) {
                                    VStack{
                                        UploadLaporanUIView()
                                            .presentationDetents([.medium, .medium])
                                            .presentationDragIndicator(.visible)
                                    }
                                }
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.top).navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        }
    }
}

struct HomeContentUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentUIView(notificationCount: 12)
    }
}

extension HomeContentUIView{
    private var headerView: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity,maxHeight: 180)
                .foregroundColor(.clear)
                .overlay {
                    Color.teal.opacity(0.2)
                }
            VStack(alignment:.leading,spacing: 0) {
                if userViewModel.user != nil {
                    HStack{
                        Text("\(userViewModel.user!.nama)")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "bell")
                            .font(.headline)
                            .padding(.trailing)
                    }.padding(.bottom)
                    Text("\(userViewModel.user!.nrp)")
                        .font(.subheadline)
                    Text(userViewModel.user!.company)
                        .font(.subheadline)
                    Text("\(userViewModel.user!.dosen_name)")
                        .font(.subheadline)
                }else{
                    HStack{
                        Text("Nama Mahasiswa")
                            .font(.headline)
                        Spacer()
                        notificationLabel
                            .font(.headline)
                            .padding(.trailing)
                        
                        
                    }.padding(.bottom)
                    Text("183040000")
                        .font(.subheadline)
                    Text("Gojek")
                        .font(.subheadline)
                    Text("Dosen Pendamping")
                        .font(.subheadline)
                }
            }.onAppear{
                userViewModel.fetchUser()
            }
            .padding([.horizontal,.top])
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }//:MARK HeadeView
    
    private var listActivity: some View{
        List(reportViewModel.reports) { report in
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
                    Text("\(report.title)")
                        .font(.headline.bold().monospaced().smallCaps())
                        .fixedSize(horizontal: false, vertical: false)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                    VStack{
                        HStack {
                            Text("status : ")
                                .font(.headline)
                                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                            Text("\(report.status)")
                                .font(.subheadline.bold().monospaced())
                                .foregroundColor(report.status == "Pending" ? .orange : (report.status == "Accepted" ? .green : .red))
                                .padding(.top,40)
                            Spacer()
                                NavigationLink(destination: DetailReportingUIView(report: report)){
                                    Text("detail")
                                        .fontWeight(.semibold)
                                        .font(.callout)
                                }
                            
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.blue.opacity(0.8))
                            .cornerRadius(14)
                            .frame(width: 100)
                            .padding([.trailing,.top])
                        }
                    }
                }
            }
        }.listStyle(.plain)
            .onAppear {
                self.reportViewModel.fetchReports { (result: Result<[Report], Error>) in
                    switch result {
                    case .success(let reports):
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.reportViewModel.reports = reports
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }//:MARK listActivity
    
    private var btnAddReport: some View{
        
        Image(systemName: "plus.circle.fill"
        )
        .font(.largeTitle)
        .symbolRenderingMode(.multicolor)
        .foregroundColor(.white)
        .scaledToFit()
        .padding(10)
        
        
    }//:MARK btnAddReport
    private var menuPopUp: some View{
        Menu{
            btnMenu
        }label: {
            btnAddReport
        }
    }
    private var btnMenu: some View{
        VStack {
            Button(action: {
                isShowingAddReportSheet.toggle()
            }) {
                Text("Add Bimbingan")
            }
            .padding()
            Button(action: {
                isShowingUploadFileSheet.toggle()
            }) {
                Text("Upload Konversi Nilai")
            }
            .padding()
        }
    }//:MARK btnMenu
    private var notificationLabel: some View{
        ZStack {
            NavigationLink(
                destination: MahasiswaNotificationUIView(),
                label: {
                    Image(systemName: "bell")
                        .font(.system(size: 28))
                        .foregroundColor(Color.black)
                        
                })
            if notificationCount > 0 {
                ZStack{
                    Capsule()
                        .fill(Color.red)
                        .frame(width: 20,height: 20)
                        .offset(x: 12, y: -10)
                    Text("\(notificationCount)")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .offset(x: 12, y: -10)
                }
            }
        }
    }
}
