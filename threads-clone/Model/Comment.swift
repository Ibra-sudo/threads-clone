//
//  Comment.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 21.07.24.
//

import Foundation
import FirebaseFirestore

struct Comment: Identifiable, Codable {
    @DocumentID var commentId: String?
//    @DocumentID var threadId: String?
    
    let ownerUid: String
//    let threadId: String
    let caption: String
    let timestamp: Timestamp
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
    
    var user: User?
}
