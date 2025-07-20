//
//  SessionManager.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 23.06.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@Observable
class SessionManager {
    enum AppScreen {
        case auth, main, loading
    }
    
    var user: User?
    var currentScreen: AppScreen = .loading
    
    let userModel = UserModel()
     
    init() {
        authChanges()
    }
    
    private func authChanges() {
        let _ = Auth.auth().addStateDidChangeListener { _, user in
            Task {
                if user != nil {
                    try? await self.loadUser()
                    self.currentScreen = .main
                } else {
                    self.user = nil
                    self.currentScreen = .auth
                }
            }
        }
    }
    
    func login(email: String, password: String) async throws {
        let user = try await userModel.login(email: email, password: password)
        self.user = user
        try await loadUser()
    }
    
    private func loadUser() async throws {
        user = try await userModel.loadUser()
    }

    
    func signOut() {
        try? Auth.auth().signOut()
        currentScreen = .auth
    }
}

