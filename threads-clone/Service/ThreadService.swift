//
//  ThreadService.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 15.07.24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore.firestore().collection("threads").whereField("ownerUid", isEqualTo: uid).getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func deleteUserThread(uid: String) async throws {
        let thread = Firestore.firestore().collection("threads").document(uid)
        
        try await thread.delete()
        
    }
    
    static func likeUserThread(thread: Thread, uid: String) async throws {
        let document = Firestore.firestore().collection("threads").document(thread.id)
        try await document.updateData(["likes": FieldValue.arrayUnion([uid])])
    }
    
    static func unlikeUserThread(thread: Thread, uid: String) async throws {
        let document = Firestore.firestore().collection("threads").document(thread.id)
        try await document.updateData(["likes": FieldValue.arrayRemove([uid])])
    }
    
    static func uploadComment(thread: Thread, comment: Comment) async throws {
        let document = Firestore.firestore().collection("threads").document(thread.id)
        try await document.updateData(["comments": FieldValue.arrayUnion([Firestore.Encoder().encode(comment)])])
    }
    
    static func fetchThreadsWithUserComments(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .getDocuments()
        
        let threads = snapshot.documents.compactMap { document -> Thread? in
            let thread = try? document.data(as: Thread.self)
            guard let thread = thread else { return nil }
            let userComments = thread.comments.filter { $0.ownreUid == uid }
            return userComments.isEmpty ? nil : thread
        }
        
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func fetchComments() async throws -> [Comment] {
        let threads = try await fetchThreads()
        var comments = [Comment]()
        
        for thread in threads {
            comments.append(contentsOf: thread.comments)
        }
        
        return comments
    }
}
