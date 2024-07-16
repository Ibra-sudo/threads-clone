//
//  Thread.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 15.07.24.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    
    @DocumentID var threadId: String?
    
//    let id: String
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
}
