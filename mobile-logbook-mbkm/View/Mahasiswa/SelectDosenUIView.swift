//
//  SelectDosenUIView.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 08/02/23.
//

import SwiftUI

struct SelectDosenUIView: View {
    @State private var selectedDosenIndex = 0
    
    let dosenList = ["Dosen 1", "Dosen 2", "Dosen 3", "Dosen 4"]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("Select Dosen")
                .font(.title)
                .fontWeight(.heavy)
            Section{
                Picker("Selected", selection: $selectedDosenIndex){
                    ForEach(dosenList, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
            }.padding([.leading])
            
            Button(action: {
                // Action to be taken when the "Done" button is pressed
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5)
                    
            }
        }.padding()
    }
}

struct SelectDosenUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDosenUIView()
    }
}
