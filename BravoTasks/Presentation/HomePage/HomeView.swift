//
//  HomeView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 31.05.2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    NotificationBellView(count: 2)
                        .onTapGesture {
                            print("Notifications")
                        }
                }
                
                Text("Сегодня")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 2)
                    .padding(.top, 4)
                    .padding(.horizontal, 20)
                
                Text(DateFormatterHelper.dayAndWeekday(from: Date()))
                    .foregroundColor(.secondary)
                    .bold()
                    .padding(.horizontal, 20)
                
                TasksScrollView()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

}

#Preview {
    HomeView()
}

