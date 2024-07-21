//
//  CommentThreadViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 20.07.24.
//

import Firebase

class CommentThreadViewModel: ObservableObject {
    
    func uploadComment(thread: Thread, caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(ownreUid: uid, caption: caption, timestamp: Timestamp())
        try await ThreadService.uploadComment(thread: thread, comment: comment)
    }
}
