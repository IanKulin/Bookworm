//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ian Bailey on 30/10/2022.
//

import SwiftUI

@main
struct BookwormApp: App {

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
