//
//  Settings.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 19.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var showingAlert = false
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // App Icon
    var appIconMode = ["Beautiful", "Old", "Retro", "Dark"]
    @State private var selectedAppIconMode = 0

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    NavigationLink(destination: SettingsAppearance()) {
                        Text("Appearance")
                    }


                    NavigationLink(destination: SettingsAppIcon()) {
                        Text("App Icon")
                    }
                }
                
                Section(header: Text("Sync")) {
                    NavigationLink(destination: SettingsiCloud()) {
                        Text("iCloud")
                    }
                    NavigationLink(destination: SettingsSync()) {
                        Text("Update Shows")
                    }
                }
                
                Section(header: Text("Feedback")) {
                    HStack {
                        Link("Send Feedback", destination: URL(string: "mailto:support@couchtim.es")!)
                    }
                    HStack {
                        Link("Please Rate CouchTimes", destination: URL(string: "https://www.youtube.com/watch?v=oHg5SJYRHA0")!)
                    }
                }
                
                Section(header: Text("Information")) {
                    NavigationLink(destination: SettingsAbout()) {
                        Text("About")
                    }
                    HStack {
                        Link("Privacy Policy", destination: URL(string: "https://couchtim.es/privacy-policy/")!)
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
                    .fontWeight(.medium)
            }))
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                self.showingAlert = true
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Update all shows"),
                    message: Text("Do you want to force update all your saved shows? This can take a while..."),
                    primaryButton: .default(Text("Update"), action: forceUpdateAllShows),
                    secondaryButton: .destructive(Text("Cancel"))
                )
            }
        }
    }
}

extension Settings {
    private func forceUpdateAllShows() {
        viewModel.updateShows(forceUpdateAllShows: true)
    }
    
    private func updateShows() {
        print("updateShows")
        viewModel.updateShows(forceUpdateAllShows: false)
    }
}

extension NSNotification.Name {
    public static let deviceDidShakeNotification = NSNotification.Name("MyDeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
    }
}
