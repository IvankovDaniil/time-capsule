//
//  TextFieldAuthView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 15.06.2025.
//

import SwiftUI

enum FieldType {
    case standart, email, password
}

struct TextFieldAuthView: View {
    var title: String
    @Binding var text: String
    var fieldType: FieldType = .standart
    @State private var isSecure: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.text, lineWidth: 1)
                .frame(height: 45)
            HStack {
                if fieldType == .email {
                    Image(systemName: "envelope")
                }
                
                if fieldType == .password {
                    if isSecure {
                        SecureField(title, text: $text)
                    } else {
                        TextField(title, text: $text)
                    }
                    
                    Button {
                        isSecure.toggle()
                    } label: {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                    }

                } else {
                    TextField(title, text: $text)
                }
            }
            .padding()
        }
    }
}
