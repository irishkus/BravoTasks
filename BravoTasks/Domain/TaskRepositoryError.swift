//
//  TaskRepositoryError.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 23.07.2026.
//

import Foundation

enum TaskRepositoryError: LocalizedError {

    case taskNotFound(UUID)
    case taskAlreadyExists(UUID)

    var errorDescription: String? {
        switch self {
        case .taskNotFound:
            return "Задача не найдена"

        case .taskAlreadyExists:
            return "Задача уже существует"
        }
    }
}
