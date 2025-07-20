//
//  FutureCapsuleFlow.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 30.06.2025.
//

import SwiftUI

struct FutureCapsuleFlow: View {
    @Environment(SessionManager.self) var sessionManager
    @State private var isPresented = false
    @State var futureCapsuleViewModel = FutureCapsuleViewModel()
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            FutureCapsuleView(sessionManager: sessionManager, viewModel: $futureCapsuleViewModel)
            
            
            AddCapsuleButtonView(action: {
                isPresented.toggle()
            })
            .padding(.trailing)
            .padding(.bottom, UIConstants.tabBarHeight)
        }
        .fullScreenCover(isPresented: $isPresented) {
            AddCapsuleView(viewModel: $futureCapsuleViewModel, action: { isPresented = false } )
        }
    }
}


private struct AddCapsuleButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(.text)
                    .frame(width: 50, height: 50)
                
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
        }
    }
}
