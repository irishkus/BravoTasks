//
//  EmptyDailyTaskView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 04.08.2026.
//

import SwiftUI

struct EmptyDailyTaskView: View {
    var body: some View {
        HStack {
            Image("emptyDone")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.trailing, 6)
            VStack(alignment: .leading) {
                Text("Задач пока нет")
                    .font(.callout)
                    .bold()
                Text("Создайте ежедневную привычку, \nчтобы она появилась здесь.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 2)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.secondary)
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    Color.gray.opacity(0.15),
                    lineWidth: 1
                )
        }
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 3
        )
    }
}

#Preview {
    EmptyDailyTaskView()
}
