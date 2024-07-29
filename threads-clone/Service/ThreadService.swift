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
    
//    static func fetchLikesForThreads() async throws -> [String: [String]] {
//        var likesDictionary = [String: [String]]()
//        
//        let snapshot = try await Firestore
//            .firestore()
//            .collection("threads")
//            .order(by: "timestamp", descending: true)
//            .getDocuments()
//        
//        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
//        
//        for thread in threads {
//            if let threadId = thread.threadId {
//                likesDictionary[threadId] = thread.likes
//            }
//        }
//        
//        return likesDictionary
//    }
    
    static func uploadComment(thread: Thread, comment: Comment) async throws {
        let document = Firestore.firestore().collection("threads").document(thread.id)
        try await document.updateData(["comments": FieldValue.arrayUnion([Firestore.Encoder().encode(comment)])])
    }
    
    static func fetchThreadsWithComments(uid: String) async throws -> [ThreadCommentPair] {
        var threadCommentPairs = [ThreadCommentPair]()
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
        
        for var thread in threads {
            
            if let threadOwner = try? await UserService.fetchUser(withUid: thread.ownerUid) {
                thread.user = threadOwner
            }
            
            var filteredComments = thread.comments.filter { $0.ownerUid == uid }
            
            for i in 0 ..< filteredComments.count {
                if let commentOwner = try? await UserService.fetchUser(withUid: filteredComments[i].ownerUid) {
                    filteredComments[i].user = commentOwner
                }
            }
            
            if !filteredComments.isEmpty {
                let pair = ThreadCommentPair(thread: thread, comments: filteredComments)
                threadCommentPairs.append(pair)
            }
        }
        return threadCommentPairs
    }
    
    static func repostThread(thread: Thread, uid: String) async throws {
        let repostDecument = Firestore.firestore().collection("threads").document(thread.id)
        try await repostDecument.updateData(["repostedBy": FieldValue.arrayUnion([uid])])
    }
    
    static func unrepostThread(thread: Thread, uid: String) async throws {
        let document = Firestore.firestore().collection("threads").document(thread.id)
        try await document.updateData(["repostedBy": FieldValue.arrayRemove([uid])])   
    }
    
//    static func fetchRepostThreads(uid: String) async throws -> [Repost] {
//        var repostThreads = [Repost]()
//        let snapshot = try await Firestore
//            .firestore()
//            .collection("threads")
//            .whereField("repostedBy", arrayContains: uid)
//            .order(by: "timestamp", descending: true)
//            .getDocuments()
//        
//        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
//        
//        for thread in snapshot.documents {
//            if let repost = try? thread.data(as: Repost.self) {
//                repostThreads.append(repost)
//            }
//        }
//        
//        return repostThreads
//    }
}

//    static func fetchLikes(uid: String) async throws -> [Like] {
//        var likes = [Like]()
//        let snapshot = try await Firestore.firestore().collection("threads").getDocuments()
//        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
////        let likes = snapshot.documents.compactMap({ try? $0.data(as: Like.self) })
//        for var thread in threads {
//            if let likeOwner = try? await UserService.fetchUser(withUid: thread.ownerUid) {
//                thread.user = likeOwner
//            }
//            var likes = thread.likes
//
//            if !likes.isEmpty {
//                let like = Like(likeId: "", likes: likes)
//                likes.append(like)
//            }
//        }
//
//        return likes
//    }
