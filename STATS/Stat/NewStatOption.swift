//
//  NewStatOption.swift
//  STATS
//
//  Created by Staff on 19/06/2024.
//

import SwiftUI

struct NewStatOption: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack{
            Text("New Stat")
                .font(.largeTitle)
            
            NavigationLink {
                CounterForm(selectedTab: $selectedTab)
            } label: {
                  Text("Add Counter")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                DecimalForm(selectedTab: $selectedTab)
            } label: {
                  Text("Add Decimal")
                    .padding()
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

//#Preview {
//    NewStatOption(selectedTab: 1)
//}
