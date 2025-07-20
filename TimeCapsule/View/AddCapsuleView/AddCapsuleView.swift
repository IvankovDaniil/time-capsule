//
//  AddCapsuleView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.07.2025.
//

import SwiftUI

struct AddCapsuleView: View {
    @State private var text: String = ""
    @State private var title: String = ""
    @State private var date: Date = Date.now
    @State var isSending: Bool = false
    
    @Binding var viewModel: FutureCapsuleViewModel
    
    let action: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Заголовок")
                        TextFieldView(title: "Добавьте заголовок", text: $title, fieldType: .standart)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Расскажите, что вы хотите добавить в капсулу и передать себе в будущее")
                            .font(type: .regular)
                        
                        ZStack {
                            TextEditor(text: $text)
                                .frame(height: 200)
                                .padding()
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.text, lineWidth: 1)
                        }
                        
                    }
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            HStack {
                                Spacer()
                                Image(systemName: "photo.fill")
                                Text("Добавить фото")
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .padding()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.text, lineWidth: 1)
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Дата открытия капсулы:")
                        DatePicker("",
                                   selection: $date,
                                   in: Date.now...,
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(maxHeight: 400)
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        action()
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "chevron.left")
                            Text("Назад")
                                .font(type: .medium)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSending = true
                    } label: {
                        Text("Отправить")
                            .font(type: .medium)
                    }
                }
            })
            .fullScreenCover(isPresented: $isSending, content: {
                VideoBackgroundView(videoName: "closeCapsuleVideos", videoType: "mp4") {
                    isSending = false
                    
                    Task {
                        try await viewModel.addCapsule(title: title, description: text, date: date)
                        action()
                    }
                }
                .ignoresSafeArea()
            })
            .padding(.horizontal)
            .scrollIndicators(.never)
        }
    }
}
