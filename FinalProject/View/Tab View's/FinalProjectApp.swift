//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Renad Majed on 23/11/1444 AH.
//

import SwiftUI
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        
         return true
         }
}

@main
struct   FinalProject: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    
     var body: some Scene {
         WindowGroup {
          NavigationView {
                Login()
                }
             }
        }
}
