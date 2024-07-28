//
//  Repost.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 27.07.24.
//

import Foundation
import FirebaseFirestore

struct Repost: Identifiable, Codable {
    @DocumentID var repostId: String?
    
    let ownerUid: String
    let timestamp: Timestamp
    
//    var threads: Thread
    
    var id: String {
        return repostId ?? NSUUID().uuidString
    }
    
    var user: User?
}
