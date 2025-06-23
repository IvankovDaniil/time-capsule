//
//  AuthViewSendEmail.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 23.06.2025.
//

import SwiftUI

struct AuthViewSendEmail: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .opacity(0.3)
                .frame(height: 150)
            Text("На указаную почту выслали подтверждение")
                .font(type: .bold, size: 17)
                .foregroundStyle(.white)
        }
    }
}
