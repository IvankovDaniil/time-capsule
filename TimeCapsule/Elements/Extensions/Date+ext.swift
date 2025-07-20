//
//  Date+ext.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 17.07.2025.
//
import Foundation

extension Date {
    func formatedDate() -> String {
        let formatter = DateFormatter()
    
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: self)
    }
}
