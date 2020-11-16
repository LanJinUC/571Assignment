//
//  touristLocationApp.swift
//  touristLocation
//
//  Created by Lan Jin on 2020-11-15.
//

import SwiftUI
import Firebase


@main
struct touristLocationApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
   
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        FirebaseApp.configure()
        return true
    }
}


