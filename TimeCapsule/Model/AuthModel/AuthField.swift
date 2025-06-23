//
//  AuthField.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 15.06.2025.
//
import SwiftUI

struct AuthField: Identifiable {
    var id = UUID()
    
    let label: String
    let placeholder: String
    let fieldType: FieldType
    var binding: Binding<String>
}
