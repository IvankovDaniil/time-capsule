//
//  Font.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 11.06.2025.
//
import SwiftUI

enum FontCase: String {
    case medium = "Montserrat-Medium"
    case regular = "Montserrat-Regular"
    case bold = "Montserrat-Bold"
    case light = "Montserrat-Light"
}


extension View {
    func font(type: FontCase, size: CGFloat = 16) -> some View {
        self
            .font(.custom(type.rawValue, size: size))
    }
}
