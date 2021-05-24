//
//  ShowImage+CRUD.swift
//  CouchTimes
//
//  Created by Jan Früchtl on 05.04.21.
//  Copyright © 2021 Jan Früchtl. All rights reserved.
//

import CoreData
import Foundation

extension ShowImage {
    func updateShowImageFromResponse(path: String, data: Data) {
        self.filePath = path
        self.fileData = data
        self.isPoster = true
    }
}
