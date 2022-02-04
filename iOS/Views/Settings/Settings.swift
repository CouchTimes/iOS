//
//  Settings.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 19.08.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import SwiftUI
import CloudKitSyncMonitor

struct Settings: View {
    @State private var showingAlert = false
    @StateObject private var viewModel = SettingsViewModel()
    @ObservedObject var syncMonitor = SyncMonitor.shared
    @AppStorage("lastiCloudSyncDateString") var lastiCloudSyncDateString: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    // App Icon
    var appIconMode = ["Beautiful", "Old", "Retro", "Dark"]
    @State private var selectedAppIconMode = 0
    
    var lastiCloudSyncTime: String {
        if lastiCloudSyncDateString.isEmpty {
            return "No iCoud sync happend"
        }
        return "Last updated \(lastiCloudSyncDateString)"
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return dateFormatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("iCloud Sync")) {
                    VStack(alignment: .leading, spacing: 16) {
                        // Network Status
                        if case .noNetwork = syncMonitor.syncStateSummary {
                            Label(title: {
                                Text("Please check your network connection")
                            }, icon: {
                                Image(systemName: "wifi.slash")
                                    .foregroundColor(Color.red)
                            })
                        } else {
                            Label(title: {
                                Text("Network connection available")
                            }, icon: {
                                Image(systemName: "wifi")
                                    .foregroundColor(Color.green)
                            })
                        }
                        
                        // iCloud Logged In Status
                        if case .accountNotAvailable = syncMonitor.syncStateSummary {
                            Label(title: {
                                Text("Log into your iCloud account if you want to sync")
                            }, icon: {
                                Image(systemName: "icloud.slash.fill")
                                    .foregroundColor(Color.yellow)
                            })
                        } else {
                            Label(title: {
                                Text("Logged into iCloud")
                            }, icon: {
                                Image(systemName: "icloud.fill")
                                    .foregroundColor(Color.green)
                            })
                        }
                        
                        // Last Synced
                        Label(title: {
                            Text(lastiCloudSyncTime)
                        }, icon: {
                            Image(systemName: "checkmark.icloud.fill")
                                .foregroundColor(Color.green)
                        })
                    }.padding(.vertical, 12)
                }
                
                Section(header: Text("Show Library"), footer: Text("Last updated \(viewModel.lastUpdatedDateHuman)")) {
                    HStack {
                        Button("Update Library", action: forceUpdateAllShows)
                        
                        if viewModel.syncing == true {
                            Spacer()
                            ProgressView()
                        }
                    }
                }
                
                Section(header: Text("General")) {
                    NavigationLink(destination: SettingsAppearance()) {
                        Text("Appearance")
                    }
                    
                    NavigationLink(destination: SettingsAppIcon()) {
                        Text("App Icon")
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
                    .foregroundColor(Color("captionColor"))
            }))
        }
        .onAppear {
            switch syncMonitor.exportState {
            case .notStarted:
                print("iCloud Sync not started")
            case .inProgress(started: _):
                print("iCloud Sync in progress")
            case let .succeeded(started: _, ended: endDate):
                print("iCloud Sync succeeded")
                let date = dateFormatter.string(from: endDate)
                self.lastiCloudSyncDateString = date
            case .failed(started: _, ended: _, error: _):
                print("Faild iCloud Sync")
            }
        }
    }
}

extension Settings {
    private func forceUpdateAllShows() {
        viewModel.updateShows(forceUpdateAllShows: true)
    }
}
