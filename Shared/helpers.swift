//
//  File.swift
//  hn
//
//  Created by Preet Parekh on 21/02/21.
//

import Foundation
import SwiftUI

func toggleSidebar() {
    #if os(iOS)
    #else
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    #endif
}
