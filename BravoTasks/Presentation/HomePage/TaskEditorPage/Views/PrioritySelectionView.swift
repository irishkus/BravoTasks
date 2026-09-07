//
//  PrioritySelectionView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

import SwiftUI

struct PrioritySelectionView: View {
    @Binding var selectedPriority: AppTaskPriority
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Сложность")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.8))
            
            HStack(spacing: 10) {
                ForEach(AppTaskPriority.allCases, id: \.self) { priority in
                    Button(action: {
                        selectedPriority = priority
                    }) {
                        VStack {
                            Text(priority.title)
                                .font(.caption)
                                .foregroundStyle(priority.textColor)
                                .padding(7)
                            
                            
                            HStack(spacing: 4) {
                                ForEach(0..<priority.circlesCount, id: \.self) { _ in
                                    Circle()
                                        .fill(priority.textColor)
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .frame(width: 40, height: 8)
                            .padding(.bottom, 10)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)

                        .overlay {
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(
                                    priority != selectedPriority ? Color.gray.opacity(0.15) : priority.backgroundColor,
                                    lineWidth: 1
                                )
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 18)
                                    .fill(Color(.systemBackground))

                                if priority == selectedPriority {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(priority.backgroundColor)
                                        .opacity(0.1)
                                }
                        }
                        .shadow(
                            color: Color.black.opacity(0.06),
                            radius: 8,
                            x: 0,
                            y: 3
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.top, 12)
    }
}

#Preview {
    PrioritySelectionView(selectedPriority: .constant(.medium))
}
