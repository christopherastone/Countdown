//
//  ContentView.swift
//  Countdown
//
//  Created by Christopher A. Stone on 3/22/21.
//  Inspired in part by
//   https://stackoverflow.com/questions/64949572/how-to-create-status-bar-icon-menu-with-swiftui-like-in-macos-big-sur

import SwiftUI


// Global so that the PulldownView can refresh the title
// if the user specifies a new date in the date picker
var statusItem: NSStatusItem?

// Update the count in the menu bar, for a new end date
func updateCount(endDate: Date) {
    let diffInDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day!
    statusItem?.button?.title = String(diffInDays)+" days"

}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @AppStorage("targetDate") var targetDate = Date()

    @objc func do_exit() {
        exit(0)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let menu = NSMenu()

        // Add the date picker to the menu
        let view = NSHostingView(rootView: PulldownView())
        // Don't forget to set the frame, otherwise it won't be shown.
        view.frame = NSRect(x: 0, y: 0, width: 150, height: 150)

        let menuItem = NSMenuItem()
        menuItem.target = self
        menuItem.view = view

        menu.addItem(menuItem)

        //Add a quit option
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(do_exit), keyEquivalent: ""))

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.menu = menu

        // Update the menu bar item initially
        updateCount(endDate: targetDate)
        
        // Update the menu count every hour, in case midnight has passed.
        Timer.scheduledTimer(withTimeInterval: 60*60, repeats: true) { _ in
            updateCount(endDate: self.targetDate)
        }
    }
}

