//
//  AuthView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 15.06.2025.
//

import SwiftUI

struct AuthView: View {
    @State var viewModel: AuthViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    
    let action: () -> Void
    
    @State var isForgotPass: Bool = false
    
    var authField: [AuthField] {
        [
            AuthField(label: "Email", placeholder: "Email", fieldType: .standart, binding: $email),
            AuthField(label: "Пароль", placeholder: "Пароль", fieldType: .password, binding: $password),
        ]
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Image(systemName: "arrow.uturn.backward.square.fill")
                    .resizable()
                    .frame(width: 117, height: 101)
                
                Text("С возвращением")
                    .font(type: .bold, size: 18)
                    .foregroundStyle(.text)
                
                Text("Войдите для продолжения")
                    .font(type: .medium)
                    .foregroundStyle(.text)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(authField) { field in
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
                
                HStack {
                    Spacer()
                    Button {
                        isForgotPass.toggle()
                    } label: {
                        Text("Забыли пароль?")
                    }
                    
                }
            }
            .font(type: .medium)
            .foregroundStyle(.text)
            .sheet(isPresented: $isForgotPass) {
                ForgotPassView(viewModel: viewModel) {
                    isForgotPass.toggle()
                }
                .presentationDetents([.medium])
                .ignoresSafeArea(.container, edges: .top)
            }
            
            Button {
                Task {
                    await viewModel.authUser(email: email, password: password)
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.text)
                        .frame(height: 50)
                    Text("Войти")
                        .foregroundStyle(.white)
                        .font(type: .bold, size: 18)
                }
            }
            
            HStack {
                Text("Нет аккаунта?")
                
                Button {
                    action()
                } label: {
                    Text("Зарегистрироваться")
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
        .padding(.horizontal, 20)
    }
    
}

