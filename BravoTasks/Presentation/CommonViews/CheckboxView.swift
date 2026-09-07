//
//  CheckboxView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 02.06.2026.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isSelected: Bool

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .font(.system(size: 24))
                .foregroundStyle(isSelected ? Color.bravoBasicPurple : Color.gray)
        }
        .buttonStyle(.plain)
    }
}
