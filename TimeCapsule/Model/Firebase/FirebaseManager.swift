//
//  FirebaseManager.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 16.06.2025.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    func registerUser(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = result.user.uid
        
        try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData([
                "name": name,
                "email": email,
                "createdAt": Timestamp()
            ])
        
        do {
            try await result.user.sendEmailVerification()
        } catch {
            print("❌ Ошибка при отправке письма: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signInUser(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        
        if let user = Auth.auth().currentUser, !user.isEmailVerified {
            try? Auth.auth().signOut()
            return
        }
    }
    
    func forgotPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
