//
//  FutureCapsuleView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.06.2025.
//

import SwiftUI
import FirebaseAuth

struct FutureCapsuleView: View {
    var sessionManager: SessionManager
    @Binding var viewModel: FutureCapsuleViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                if let user = sessionManager.user {
                    TitleCapsuleView(user: user)
                    
                    Text("Закрытые капсулы:")
                        .font(type: .bold, size: 20)
                    
                    ForEach(viewModel.capsules) { capsule in
                        CapsuleView(capsule: capsule)
                    }
                    
                    if viewModel.capsules.isEmpty {
                        Text("Нет отправленных в будущее капсул")
                            .font(type: .medium)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(type: .bold, size: 18)
                            .foregroundStyle(.red)
                    }
                        
                } else {
                    ProgressView()
                }
            }
            .task {
                try? await viewModel.fetchCapsules()
            }
            
        }
        .scrollIndicators(.never)
    }
}


private struct CapsuleView: View {
    let capsule: Capsule
    
    var body: some View {
        HStack {
            Image(.capsule)
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Закрыта до \(capsule.date.formatedDate())")
                    .font(type: .light, size: 14)
                    .foregroundStyle(.gray)
                Text(capsule.title)
                    .font(type: .regular, size: 16)
                    .foregroundStyle(.black)
            }
            Spacer()
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.text, lineWidth: 2)
        }
    }
}
