//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    @StateObject var viewModel: ToDoItemViewModel = ToDoItemViewModel()
    init() {
        NotificationManager.instance.requestNotification()
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: viewModel)
        }
    }
}
