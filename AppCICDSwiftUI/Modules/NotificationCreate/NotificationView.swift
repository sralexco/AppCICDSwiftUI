//
//  NotificationView.swift
//  AppCICDSwiftUI
//
//  Created by alex on 7/06/25.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    @State private var text: String = ""
    @State private var selectedValue: Int = 0
    let listIntervals: [String] = ["5 Seconds", "10 Seconds", "15 Seconds"]
    let listIntervalsValues: [Double] = [5.0, 10.0, 15.0]
    @State private var navigateToNotificationsList = false
    @State private var navigateToAbout = false
    
    @State var notificationsArray:[NotificationItem] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Notification Alarm")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notification Text")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    TextField("Enter the text", text: $text)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Interval")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Picker("Intervals", selection: $selectedValue) {
                        ForEach(listIntervals.indices, id: \.self) { index in
                            Text(listIntervals[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: {
                    createNotificationAction()
                }) {
                    Text("Create Notification")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top)
                
                
                Button(action: {
                    goHistoryAction()
                }) {
                    Text("Go to History of Notifications")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top)
                
                
                Button(action: {
                    goAboutAction()
                }) {
                    Text("Go to About")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top)
                
                NavigationLink(destination: NotificationsListView(notifications: $notificationsArray), isActive: $navigateToNotificationsList) {
                    EmptyView()
                }
                NavigationLink(destination: AboutView(), isActive: $navigateToAbout) {
                    EmptyView()
                }
                
                
                Spacer()
            }
            .padding()
            .onAppear {
                requestNotificationPermission()
            }
        }
    }
    
    func createNotificationAction() {
        scheduleNotification()
    }
    
    func goHistoryAction() {
        navigateToNotificationsList = true
    }
    
    func goAboutAction() {
        navigateToAbout = true
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Permission error: \(error)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }
    
    func scheduleNotification() {
        print("Notification Created")
        let content = UNMutableNotificationContent()
        content.title = "Notifficiation Alarm!"
        content.body = text
        content.sound = UNNotificationSound.default
        
        let notification = NotificationItem(title: text, date: Date())
        notificationsArray.append(notification)
        
        let interval = listIntervalsValues[selectedValue]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error)")
            }
        }
    }
    
}
