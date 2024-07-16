//
//  PreviewProvider.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}


class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "Max Moro", email: "max@gmail.com", username: "maxmoro1")
    
    let thread = Thread(ownerUid: "123", caption: "This is a test thread", timestamp: Timestamp(), likes: 0)
}
