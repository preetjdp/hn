//
//  ContentView.swift
//  Shared
//
//  Created by Preet Parekh on 21/02/21.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Set<Int> = [0]
    @State var showComposeWindow = false
    
    var body: some View {
        NavigationView {
            NavBarView()
                .frame(minWidth: 250, idealWidth: 250, maxHeight: .infinity)
        }
        .navigationTitle("Hacker News Reader")
        .toolbar {
            
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                }
            }
            
            ToolbarItem(placement: .navigation) {
                Button(action: { self.showComposeWindow = true }) {
                    Image(systemName: "magnifyingglass")
                }.popover(isPresented: $showComposeWindow) {
                    Compose(showComposeWindow: $showComposeWindow)
                }
            }
            
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

struct Compose: View {
    @Binding var showComposeWindow: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color("AccentColor"))
                    .opacity(0.7)
                    .font(.system(size: 40))
                Text("What's happening?")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Divider()
            HStack {
                Image(systemName: "camera")
                Spacer()
                Image(systemName: "photo")
                Spacer()
                Image(systemName: "chart.bar.xaxis")
                Spacer()
                Image(systemName: "mappin.and.ellipse")
            }
            .font(.title3)
            .foregroundColor(.secondary)
            .padding()
        }
    }
}

struct NavBarView: View {
    @State private var isLoading = false
    @State private var favoriteColor = 0
    
    var body: some View {
        TabView {
            Text("New")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("New")
                }
            Text("Past")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Past")
                }
            Text("Show")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Show")
                }
        }
        .font(.headline)
//        VStack {
//            VStack {
//                Picker("", selection: $favoriteColor) {
//                    Text("New").tag(0)
//                    Text("Past").tag(1)
//                    Text("Show").tag(2)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .labelsHidden()
//
////                Spacer()
////
////                Button("Toggle") {
////                    isLoading.toggle()
////                }
//            }
//            .padding(20)
//            .frame(height: 100, alignment: .center)
            
//            Divider()
            
//            VStack {
//                if isLoading {
//                    ProgressView()
//                } else {
//                    List() {
//                        ForEach((1...1000).reversed(), id: \.self) {
//                            symbol in Module(title: "Stand Hours", value: "6", subtitle: "hr")
//                        }
//                    }.frame(minWidth: 200, alignment: .center)
//                    .padding(0)
//                }
//            }.frame(maxHeight: .infinity, alignment: .center)
//        }.frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
