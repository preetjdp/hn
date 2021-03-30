//
//  hnApp.swift
//  Shared
//
//  Created by Preet Parekh on 21/02/21.
//

import SwiftUI

@main
struct hnApp: App {
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
