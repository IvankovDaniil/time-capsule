//
//  TimeCapsuleApp.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.06.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    return true
  }
}

@main
struct TimeCapsuleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var sessionManager: SessionManager
    init() {
        FirebaseApp.configure()
        sessionManager = SessionManager()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch sessionManager.currentScreen {
                case .auth: RegView()
                case .main: MainFlow()
                case .loading: ProgressView()
                }
            }
            .environment(sessionManager)
        }
        
    }
}
