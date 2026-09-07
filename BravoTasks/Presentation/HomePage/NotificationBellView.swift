//
//  NotificationBellView.swift
//  BravoTasks
//
//  Created by Ирина Соловьева on 31.05.2026.
//

import SwiftUI

struct NotificationBellView: View {
    var count: Int = 2

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "bell")
                .font(.system(size: 26, weight: .regular))
                .foregroundStyle(.black)

            Text("\(count)")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 16, height: 16)
                .background(Color(red: 0x5B / 255, green: 0x36 / 255, blue: 0xD9 / 255))
                .clipShape(Circle())
                .offset(x: 2, y: -2)
        }
        .frame(width: 36, height: 36)
        .padding(.trailing, 20)
    }
}
