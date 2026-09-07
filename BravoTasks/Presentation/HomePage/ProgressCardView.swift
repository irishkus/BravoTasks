//
//  ProgressCardView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 31.05.2026.
//

import SwiftUI

struct ProgressCardView: View {
    var numberOfCompletedTasks: Int
    var numberOfTasksToday: Int
    var bravo = "Отличный темп! 🎉"
    var progress: Double {
        guard numberOfTasksToday > 0 else { return 0 }
        return Double(numberOfCompletedTasks) / Double(numberOfTasksToday)
    }
    
    var body: some View {
            HStack {
                ZStack {
                    StarPath()
                    Image(systemName: "star.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(width: 100, height: 95)
                
                if numberOfTasksToday > 0 {
                    VStack(alignment: .leading) {
                        Text("Выполнено \(numberOfCompletedTasks) из \(numberOfTasksToday)")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 3)
                        Text(bravo)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 5)
                            .frame(width: 64, height: 64)
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color.bravoBasicPurple, lineWidth: 5)
                            .frame(width: 64, height: 64)
                            .rotationEffect(.degrees(-90))
                            .overlay {
                                Text("\(Int(progress * 100))%")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                
                            }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Ваш день чистый!")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 3)
                        Text("Отличный момент, чтобы \nспланировать важное.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    
                    Image("emptyDone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
            }
            .padding(EdgeInsets(top: 6, leading: 0, bottom: 10, trailing: 20))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(
                        color: .black.opacity(0.12),
                        radius: 12,
                        x: 0,
                        y: 6
                    )
            )
    }
}

#Preview {
    ProgressCardView(numberOfCompletedTasks: 1, numberOfTasksToday: 0)
}
