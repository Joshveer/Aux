//
//  AuxRemakeApp.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/26/24.
// Josh is stinky poo poo peep ee

import SwiftUI
import Firebase

@main
struct AuxRemakeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

