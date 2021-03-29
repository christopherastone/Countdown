//
//  CountdownApp.swift
//  Countdown
//
//  Created by Christopher A. Stone on 3/22/21.
//

import SwiftUI
import AppKit

@main
struct CountdownApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
