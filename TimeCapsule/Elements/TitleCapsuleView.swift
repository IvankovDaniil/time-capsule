//
//  TitleCapsuleView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.07.2025.
//

import SwiftUI

struct TitleCapsuleView: View {
    let user: User
    
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                AsyncImage(
                    url: URL(string: user.ava ?? "")) {_ in
                        Image(.userAva)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                
                Text("Привет, \(user.name)")
                    .font(type: .medium)
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                Image(.tune)
                    .resizable()
                    .frame(width: 24, height: 24)
                }

        }
    }
}
