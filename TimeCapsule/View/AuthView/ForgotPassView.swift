//
//  ForgotPassView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 16.06.2025.
//

import SwiftUI

struct ForgotPassView: View {
    @State private var email: String = ""
    var action: () -> Void
    
    @State var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Button {
                    action()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 33, height: 33)
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 11, height: 11)
                            .foregroundStyle(.black)
                    }
                }
            }
            
            Text("Забыли пароль?")
                .font(type: .bold, size: 22)
            
            VStack(spacing: 30) {
                
                Text("Введите Email адресс и мы вышлем на почту ссылку для восстановления пароля")
                
                TextFieldAuthView(title: "Введите Email адресс", text: $email, fieldType: .standart)
                
                Button {
                    Task {
                       await viewModel.sendPasswordRest(to: email)
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.text)
                            .frame(height: 50)
                        HStack {
                            Image(.send)
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("Отправить")
                                .foregroundStyle(.white)
                                .font(type: .bold, size: 18)
                        }
                    }
                }

            }
        }
        .overlay(content: {
            if viewModel.isEmailSend {
                AuthViewSendEmail()
            }
        })
        .padding(.horizontal, 20)
    }
}
