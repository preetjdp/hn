//
//  hnApp.swift
//  Shared
//
//  Created by Preet Parekh on 21/02/21.
//

import SwiftUI

@main
struct hnApp: App {
    /**
     The following code tries to add the menu bar app
     */
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var popOver: NSPopover!
    var statusBarItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let clockView = ClockView()
        NSApp.dockTile.contentView = NSHostingView(rootView: clockView)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            NSApp.dockTile.display()
        }
        timer.fire()
        
        let store = Store()
        
        let menuView = MenuView().environmentObject(store)
        
        let popOver = NSPopover()
        popOver.contentSize = NSSize(width: 350, height: 350)
        popOver.behavior = .transient
        popOver.animates = true
        //        popOver.contentViewController = NSViewController()
        popOver.contentViewController = NSHostingController(rootView: menuView)
        //        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
        
        self.popOver = popOver
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        //        self.statusBarItem.title = "hn"
        
        //        #if !os(macOS)
        //        self.statusBarItem.view = MarqueeText(font: UIFont.preferredFont(forTextStyle: .subheadline), leftFade: 16, rightFade: 16, startDelay: 3, text: "HelloHelloHelloHelloHello HelloHelloHello HelloHello")
        //        #endif
        
        if let MenuButton = self.statusBarItem.button {
            //
            if store.showPosts.count == 0 {
                MenuButton.title = "hn"
                
            } else {
                MenuButton.title = store.newPosts[0].title
            }
            
            
            //            MenuButton.image = NSImage(systemSymbolName: "pencil", accessibilityDescription: "etst")
            MenuButton.action = #selector(MenuButtonToggle)
        }
    }
    
    @objc func MenuButtonToggle() {
        //        print("hello")
        if let menuButton = statusBarItem?.button {
            self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
        }
    }
}
