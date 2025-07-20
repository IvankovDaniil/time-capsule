//
//  FirebaseManager.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 16.06.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseManager {
    
    //MARK: - Регистрация
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
    //MARK: - Авторизаця
    func signInUser(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        
        if let user = Auth.auth().currentUser, !user.isEmailVerified {
            try? Auth.auth().signOut()
            return
        }
    }
    //MARK: - Восстановления паролья
    func forgotPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    //MARK: - Получения пользователя
    func fetchUser() async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No UID", code: -1)
        }
        
        let doc = try? await Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument()
        
        guard let data = doc?.data()  else {
            throw NSError(domain: "NO DATA", code: -2)
        }
        return User(
            id: uid,
            ava: data["ava"] as? String,
            name: data["name"] as? String ?? "",
            email: data["email"] as? String ?? ""
            )
    }
    
    //MARK: - Добавления капсулы
    func addCapsule(capsule: Capsule) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data = try Firestore.Encoder().encode(capsule)
        
        try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("capsules")
            .document(capsule.id)
            .setData(data)
    }
    
    func fetchCapsules() async throws -> [Capsule]{
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("capsules")
            .getDocuments()
        
        return snapshot.documents.compactMap( {
            try? $0.data(as: Capsule.self)
        })
    }
}
