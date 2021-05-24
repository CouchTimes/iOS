//
//  StorageProvider.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 28.12.20.
//  Copyright © 2020 Jan Früchtl. All rights reserved.
//

import CoreData
class StorageProvider {
    static let shared = StorageProvider()
    let persistentContainer: NSPersistentCloudKitContainer
    
    init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "CouchTimes")
        
        // Get URL of new Store inside the AppGroup
        let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.fruechtl.couchtimes")!.appendingPathComponent("CouchTimes.sqlite")
        
        // Get the URL of the already existing Store inside the default Container
        var defaultURL: URL?
        if let storeDescription = persistentContainer.persistentStoreDescriptions.first, let url = storeDescription.url {
            defaultURL = FileManager.default.fileExists(atPath: url.path) ? url : nil
        }
        
        // Checks if the URL for the old Store exists. If this is the case, its creating a new Store inside the AppGroup and configures iCloud Sync
        if defaultURL == nil {
            let storeDescription = NSPersistentStoreDescription(url: storeURL)
            storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.fruechtl.couchtimes")
            storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            storeDescription.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            persistentContainer.persistentStoreDescriptions = [storeDescription]
        }
        
        // Loads the Store inside the PersistentContainer
        persistentContainer.loadPersistentStores(completionHandler: { [unowned persistentContainer] (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            // Checks if
            // 1. the URL of the already existing Store is NOT nil
            // 2. the URL of the already existing Store and the Store inside the AppGroup are NOT equal
            if let url = defaultURL, url.absoluteString != storeURL.absoluteString {
                let coordinator = persistentContainer.persistentStoreCoordinator
                
                // Checks for the already existing (old) Store
                if let oldStore = coordinator.persistentStore(for: url) {
                    
                    // Tries to run a migration of the old store to the new location inside the AppGroup
                    do {
                        try coordinator.replacePersistentStore(at: oldStore.url!, destinationOptions: nil, withPersistentStoreFrom: storeURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
                    } catch {
                        print(error.localizedDescription)
                    }

                    // Deletes the old store
                    let fileCoordinator = NSFileCoordinator(filePresenter: nil)
                    fileCoordinator.coordinate(writingItemAt: url, options: .forDeleting, error: nil, byAccessor: { url in
                        do {
                            try FileManager.default.removeItem(at: url)
                        } catch {
                            print(error.localizedDescription)
                        }
                    })
                }
            }
        })
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

extension StorageProvider {
    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                persistentContainer.viewContext.rollback()
                print("Failed to save whole context: \(error)")
            }
        }
    }
}
