//
//  RepeatSelectionView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 25.06.2026.
//

import SwiftUI

struct RepeatSelectionView: View {
    @Binding var selectedType: RepeatType
    @Binding var showRepetitionOptions: Bool
    
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Повторение")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.8))

            Button {
                //showRepetitionOptions = true
                onTap()
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "repeat")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundStyle(Color.bravoBasicPurple)

                    Text(selectedType.title)
                        .font(.subheadline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .frame(height: 52)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(.systemBackground))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
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
        .padding(.top, 12)
//        .sheet(isPresented: $showRepetitionOptions) {
//            RepetitionOptionsView(repeatType: $selectedType)
//        }
    }
}

//#Preview {
//    RepeatSelectionView(repeatType: .con)
//}
