//
//  MainFlow.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 09.06.2025.
//

import SwiftUI

enum TabBarFlow {
    case future
    case past
}

struct MainFlow: View {
    @State var currentTab: TabBarFlow = .future
    @State var currentX: CGFloat = 0
    @Namespace var animation
    
    private let buttons: [TabBarButtonConfiguraton] = [
        TabBarButtonConfiguraton(tab: .future, title: "Future", icon: "forward.end"),
        TabBarButtonConfiguraton(tab: .past, title: "Past", icon: "archivebox"),
    ]
    
    var body: some View {
        TabView(selection: $currentTab) {
            FutureCapsuleView()
                .tag(TabBarFlow.future)
            PastCapsuleView()
                .tag(TabBarFlow.past)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
            TabBarButtonLabel(
                buttons: buttons,
                currentTab: $currentTab,
                currentX: $currentX,
                animation: animation
            )
        }
    }
}

private struct TabBarButtonConfiguraton: Identifiable {
    var id: TabBarFlow { tab }
    var tab: TabBarFlow
    var title: String
    var icon: String
}

private struct TabButtonView: View {
    let button: TabBarButtonConfiguraton
    @Binding var currentTab: TabBarFlow
    @Binding var currentX: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                
                Button {
                    withAnimation(.spring) {
                        currentTab = button.tab
                        currentX = proxy.frame(in: .global).midX
                    }
                } label: {
                    Image(systemName: button.icon)
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.black)
                        .padding(currentTab == button.tab ? 10 : 0)
                        .background {
                            if button.tab == currentTab {
                                Circle()
                                    .fill(.tabBarBg)
                                    .frame(width: 50, height: 50)
                                    .transition(.offset(y: 30))
                                    .animation(.spring, value: currentTab)
                            }
                        }
                        .offset(y: currentTab == button.tab ? -30 : 0)
                    
                }
                .disabled(currentTab == button.tab)
                .onAppear {
                    if button.tab == .future && currentX == 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            currentX = proxy.frame(in: .global).midX
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

private struct TabBarButtonLabel: View {
    let buttons: [TabBarButtonConfiguraton]
    @Binding var currentTab: TabBarFlow
    @Binding var currentX: CGFloat
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(buttons) { button in
                VStack(spacing: 0) {
                    TabButtonView(button: button, currentTab: $currentTab, currentX: $currentX)
                    
                    if currentTab == button.tab {
                        Text(button.title)
                            .padding(.bottom, 10)
                            .foregroundStyle(.white)
                            .font(type: .medium, size: 14)
                    }
                }
            }
        }
        .background(
            GeometryReader { proxy in
                let localX = currentX - proxy.frame(in: .global).minX
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tabBarBg)
                    .clipShape(TabBarButtonShape(currentXValue: localX))
                    .matchedGeometryEffect(id: "customTabBar", in: animation)
            }
        )
        .padding(.horizontal)
        .padding(.bottom, 20)
        .frame(height: 90)
    }
}


#Preview {
    MainFlow()
}

