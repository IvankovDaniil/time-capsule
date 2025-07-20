//
//  Capsule.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 25.06.2025.
//
import Foundation

struct Capsule: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date
    var image: String?
    var isClose: Bool
}
