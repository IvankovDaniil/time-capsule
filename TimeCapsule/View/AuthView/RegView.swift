//
//  RegView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 15.06.2025.
//

import SwiftUI

struct RegView: View {
    @Environment(SessionManager.self) private var sessionManager
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPass: String = ""
    
    @State private var isLogin: Bool = false
    
    @State var viewModel = AuthViewModel()
    
    var regField: [AuthField] {
        [
            AuthField(label: "Имя", placeholder: "Ваше имя", fieldType: .standart, binding: $name),
            AuthField(label: "Email", placeholder: "Email", fieldType: .email, binding: $email),
            AuthField(label: "Пароль", placeholder: "Пароль", fieldType: .password, binding: $password),
            AuthField(label: "Подтвердить пароль", placeholder: "Пароль", fieldType: .password, binding: $confirmPass),
        ]
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "arrow.uturn.backward.square.fill")
                .resizable()
                .frame(width: 117, height: 101)
            
            Text("Создать аккаунт")
                .font(type: .bold, size: 18)
                .foregroundStyle(.text)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(regField) { field in
                    Text(field.label)
                    TextFieldView(title: field.placeholder, text: field.binding, fieldType: field.fieldType)
                        .padding(.bottom, 10)
                }
                
                if viewModel.errorMessage != nil {
                    Text(viewModel.errorMessage!)
                        .font(type: .regular)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
            .font(type: .medium)
            .foregroundStyle(.text)
            
            
            Button {
                Task {
                    await viewModel.validateAndRegister(name: name, password: password, confirmPassword: confirmPass, email: email)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.text)
                        .frame(height: 50)
                    Text("Зарегистрироваться")
                        .foregroundStyle(.white)
                        .font(type: .bold, size: 18)
                }
            }
            
            HStack {
                Text("Уже есть аккаунт?")
                
                Button {
                    isLogin.toggle()
                } label: {
                    Text("Войти")
                }

            }
            .font(type: .regular)
            
            Spacer()

        }
        .overlay(content: {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
        })
        .fullScreenCover(isPresented: $isLogin, content: {
            AuthView(viewModel: viewModel, action: {
                isLogin.toggle()
            })
        })
        .overlay(content: {
            if viewModel.isEmailSend {
                AuthViewSendEmail()
            }
        })
        .padding(.horizontal, 20)
    }
}



#Preview {
    RegView()
}
