//
//  MenuView.swift
//  hn (macOS)
//
//  Created by Preet Parekh on 27/06/21.
//


import SwiftUI


struct MenuView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Hackernews")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    store.refresh()
                    
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }.padding(.horizontal)
            .padding(.top)
            
            
            NavBarView()
        }
    }
    
}
