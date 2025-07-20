//
//  UserViewModel.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 24.06.2025.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@Observable
class UserModel {
    var user: User?
    
    private let firebaseManager = FirebaseManager()
    
    func login(email: String, password: String) async throws -> User {
        try await firebaseManager.signInUser(email: email, password: password)
        let user = try await loadUser()
        self.user = user
        return user
    }
    
    func loadUser() async throws -> User {
        let user = try await firebaseManager.fetchUser()
        self.user = user
        return user
    }
    
}
