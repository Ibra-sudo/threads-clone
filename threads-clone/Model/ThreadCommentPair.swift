//
//  ThreadCommentPair.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 23.07.24.
//

import Foundation
import FirebaseFirestore

struct ThreadCommentPair: Identifiable, Decodable {
    
    @DocumentID var threadCommentPair: String?
    
    var thread: Thread
    var comments: [Comment]
    
    var id: String {
        return threadCommentPair ?? thread.id
    }
    
    var user: User?
}
