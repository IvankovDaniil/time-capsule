//
//  AuthViewModel.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 16.06.2025.
//

import SwiftUI
import FirebaseAuth

@Observable
class AuthViewModel {
    let firebaseManager = FirebaseManager()
    
//    var email: String = ""
//    var name: String = ""
//    var password: String = ""
//    var confirmPassword: String = ""
    var errorMessage: String?
    var isLoading = false
    var isEmailSend = false
    
    //Регистрация пользователя
    func validateAndRegister(name: String, password: String, confirmPassword: String, email: String) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        guard password == confirmPassword else {
            withAnimation {
                errorMessage = "Пароли не совпадают"
            }
            return
        }
        
        do {
            try await firebaseManager.registerUser(email: email, password: password, name: name)
            errorMessage = ""
            isEmailSend = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isEmailSend = false
            }
        } catch {
            let nsError = error as NSError
            switch AuthErrorCode(rawValue: nsError.code) {
            case .emailAlreadyInUse:
                errorMessage = "Email уже используется"
            case .invalidEmail:
                errorMessage = "Некорректный Email"
            case .weakPassword:
                errorMessage = "Коротки пароль"
            default: errorMessage = "Неизвестная ошибка"
            }
            
        }
    }
    
    //Авторизация
    func authUser(email: String, password: String) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            try await firebaseManager.signInUser(email: email, password: password)
            errorMessage = ""
        } catch {
            let err = error as NSError
            switch AuthErrorCode(rawValue: err.code) {
            case .userNotFound:
                errorMessage = "Пользователь не найден"
            case .unverifiedEmail:
                errorMessage = "Email не подтверждён"
            case .missingEmail:
                errorMessage = "Нет такого email"
            case .wrongPassword:
                errorMessage = "Неправильный пароль"
            case .invalidCredential:
                errorMessage = "Неверный email или пароль"
            default:
                errorMessage = "Неизвестная ошибка \(AuthErrorCode(rawValue: err.code)!)"
            }
            return
        }
    }
    
    //Восстановление пароля
    func sendPasswordRest(to email: String) async {
        do {
            try await firebaseManager.forgotPassword(email: email)
            isEmailSend = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isEmailSend = false
            }
        } catch {
            
        }
    }
}

