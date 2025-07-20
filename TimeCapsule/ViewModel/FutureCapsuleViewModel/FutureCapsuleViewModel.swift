//
//  FutureCapsuleViewModel.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.07.2025.
//

import SwiftUI

@Observable
class FutureCapsuleViewModel {
    
    let fbManager = FirebaseManager()
    
    var errorMessage: String?
    var isLoading = false
    
    var capsules: [Capsule] = []

    
    //MARK: - Добавление капсулы
    
    func addCapsule(title: String,
                    description: String,
                    image: String? = nil,
                    date: Date
    ) async throws {
        let capsule = Capsule(title: title, description: description, date: date, isClose: true)
        
        do {
            try await fbManager.addCapsule(capsule: capsule)
        } catch {
            errorMessage = "Ошибка"
        }
    }
    
    //MARK: - Выгрузка капсул
    func fetchCapsules() async throws {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            capsules = try await fbManager.fetchCapsules()
        } catch {
            errorMessage = "Не удалось загрузить капсулы"
        }
    }
}

