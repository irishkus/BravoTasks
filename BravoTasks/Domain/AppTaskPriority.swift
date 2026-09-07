//
//  AppTaskPriority.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 03.06.2026.
//

import SwiftUI

enum AppTaskPriority: String, CaseIterable, Identifiable {
    case low
    case medium
    case high
    
    var id: Self { self }

    var title: String {
        switch self {
        case .low:
            return "Легко"
        case .medium:
            return "Средне"
        case .high:
            return "Сложно"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .low:
            return Color.green
        case .medium:
            return Color.yellow
        case .high:
            return Color.red
        }
    }

    var textColor: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        }
    }

    var circlesCount: Int {
        switch self {
        case .low:
            return 1
        case .medium:
            return 2
        case .high:
            return 3
        }
    }
}
