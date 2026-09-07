//
//  ContentView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 29.05.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .environment(\.symbolVariants, .none)
                    Text("Главная")
                }
            PlanView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                                .environment(\.symbolVariants, .none)
                    Text("План")
                }
            
            CalendarGeneralView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                                .environment(\.symbolVariants, .none)
                    Text("Календарь")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                        .environment(\.symbolVariants, .none)
                    Text("Профиль")
                }
        }
        .tint(Color.bravoBasicPurple)
    }
}

struct CalendarGeneralView: View {
    var body: some View {
        Text("Календарь")
    }
}

struct PlanView: View {
    var body: some View {
        Text("План")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Профиль")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
