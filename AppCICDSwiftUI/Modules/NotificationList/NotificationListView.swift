//
//  NotificationList.swift
//  AppCICDSwiftUI
//
//  Created by alex on 7/06/25.
//
import SwiftUI

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
}

struct NotificationsListView: View {
    // Example mock data — replace this with your actual data source
    @Binding var notifications: [NotificationItem]

    var body: some View {
        List(notifications) { notification in
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)
                    .font(.title3)

                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(.headline)

                    Text("Received at \(formattedDate(notification.date))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Notification History")
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
