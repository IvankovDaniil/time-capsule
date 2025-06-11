//
//  FutureCapsuleView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.06.2025.
//

import SwiftUI

struct FutureCapsuleView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("123")
                Text("123")
                Text("123")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    TitleFutureCapsuleView()
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
