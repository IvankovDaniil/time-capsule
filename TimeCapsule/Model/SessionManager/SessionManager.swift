//
//  SessionManager.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 23.06.2025.
//

import SwiftUI
import FirebaseAuth

@Observable
class SessionManager {
    enum AppScreen {
        case auth, main
    }
    
    var currentScreen: AppScreen = .auth
     
    init() {
        authChanges()
    }
    
    private func authChanges() {
        let _ = Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.currentScreen = .main
            } else {
                self.currentScreen = .auth
            }
            
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        currentScreen = .auth
    }
}

