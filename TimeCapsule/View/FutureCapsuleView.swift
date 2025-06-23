//
//  FutureCapsuleView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.06.2025.
//

import SwiftUI
import FirebaseAuth

struct FutureCapsuleView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<100) { _ in
                    Text("123")
                }
            }
            .padding(.bottom, 20)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    TitleFutureCapsuleView()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        try? Auth.auth().signOut()
                    } label: {
                        Text("Exit")
                    }

                }
            }
        }
    }
}

#Preview {
    FutureCapsuleView()
}


struct TitleFutureCapsuleView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 2) {
            Text("Будущие капсулы")
                .font(.title)
                .bold()
            Text("Отправь сообщение себе будущему")
                .font(.headline)
                .foregroundStyle(.gray)
        }
    }
}
