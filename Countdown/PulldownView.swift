//
//  PulldownView.swift
//  Countdown
//
//  Created by Christopher A. Stone on 3/29/21.
//

import SwiftUI

// https://swiftwombat.com/how-to-store-a-date-using-appstorage-in-swiftui/
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

// https://stackoverflow.com/questions/59130116/swift-how-to-apply-acceptsfirstmouse-for-app-build-with-swiftui

// Just mouse accepter
class MyViewView : NSView {
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
}

// Representable wrapper (bridge to SwiftUI)
struct AcceptingFirstMouse : NSViewRepresentable {
    func makeNSView(context: NSViewRepresentableContext<AcceptingFirstMouse>) -> MyViewView {
        return MyViewView()
    }

    func updateNSView(_ nsView: MyViewView, context: NSViewRepresentableContext<AcceptingFirstMouse>) {
        nsView.setNeedsDisplay(nsView.bounds)
    }

    typealias NSViewType = MyViewView
}


struct PulldownView: View {
    @AppStorage("targetDate") var targetDate = Date()

    var body: some View {
        DatePicker(
            "",
            selection: $targetDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .frame(width: 139, height: 148, alignment: .trailing)
        .clipped()
        .border(Color.green)
        .onChange(of: targetDate) { _ in
            print("update ", targetDate.description)
            updateCount(endDate: targetDate)
        }
        .overlay(AcceptingFirstMouse())
    }
}

struct PulldownView_Previews: PreviewProvider {
    static var previews: some View {
        PulldownView()
            .previewLayout(.sizeThatFits)
    }
}
