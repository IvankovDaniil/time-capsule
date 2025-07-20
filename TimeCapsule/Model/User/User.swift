//
//  User.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 24.06.2025.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var ava: String?
    var name: String
    var email: String
}
