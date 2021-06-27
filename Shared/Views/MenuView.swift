//
//  MenuView.swift
//  hn (macOS)
//
//  Created by Preet Parekh on 27/06/21.
//


import SwiftUI


struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hackernews")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
            NavBarView()
        }
    }
    
}
