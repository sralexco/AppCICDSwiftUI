//
//  About.swift
//  AppCICDSwiftUI
//
//  Created by alex on 7/06/25.
//
import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("📣 About Notifications")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text("This app allows you to create custom notifications at specific intervals. You can enter a personalized message and choose a time delay like 5, 10, or 15 seconds. After the selected time, your notification will appear as a local alert.")
                    .font(.body)
                    .foregroundColor(.primary)

                Text("How It Works")
                    .font(.title2)
                    .fontWeight(.semibold)

                VStack(alignment: .leading, spacing: 10) {
                    Label("Enter a custom message that will appear in the notification.", systemImage: "pencil")
                    Label("Choose an interval from the list (e.g. 5, 10, 15 seconds).", systemImage: "timer")
                    Label("Tap 'Create Notification' and wait for the alert to appear.", systemImage: "bell")
                }
                .font(.body)
                .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
}
