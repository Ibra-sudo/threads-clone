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
    
//    static func fetchThreadsWithComments(uid: String) async throws -> [ThreadCommentPair] {
//        var threadCommentPairs = [ThreadCommentPair]()
//        let snapshot = try await Firestore
//            .firestore()
//            .collection("threads")
//            .order(by: "timestamp", descending: true)
//            .getDocuments()
//        
//        let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
//        
//        for var thread in threads {
//            
//            if thread.ownerUid == uid {
//                if let threadOwner = try? await UserService.fetchUser(withUid: thread.ownerUid) {
//                    thread.user = threadOwner
//                }
//                
//                let pair = ThreadCommentPair(thread: thread, comments: thread.comments)
//                threadCommentPairs.append(pair)
//            }
//            
//            
////            let filteredComments = thread.comments.filter { $0.ownerUid == uid }
////            
////            for var comment in filteredComments {
////                if let commentOwner = try? await UserService.fetchUser(withUid: comment.ownerUid) {
////                    comment.user = commentOwner
////                }
////            }
////            
////            if !filteredComments.isEmpty {
////                
////            }
//        }
//        return threadCommentPairs
//    }
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
}


//static func fetchComments(uid: String) async throws -> [ThreadCommentPair] {
//    var threadCommentPairs = [ThreadCommentPair]()
//    let snapshot = try await Firestore
//        .firestore()
//        .collection("threads")
//        .order(by: "timestamp", descending: true)
//        .getDocuments()
//    
//    let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
////        print("comments in service: \(threads)")
//    for thread in threads {
//        let filteredComments = thread.comments.filter { $0.ownerUid == uid }
//        if !filteredComments.isEmpty {
//            let pair = ThreadCommentPair(thread: thread, comments: filteredComments)
//            threadCommentPairs.append(pair)
//        }
//    }
//    print("threadComentPair in service: \(threadCommentPairs)")
//    return threadCommentPairs
//}

//static func fetchThreadsWithComments(uid: String) async throws -> [ThreadCommentPair] {
//    var threadCommentPairs = [ThreadCommentPair]()
//    let snapshot = try await Firestore
//        .firestore()
//        .collection("threads")
//        .order(by: "timestamp", descending: true)
//        .getDocuments()
//    
//    let threads = snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
//    
//    for var thread in threads {
//        
//        if let threadOwner = try? await UserService.fetchUser(withUid: thread.ownerUid) {
//            thread.user = threadOwner
//        }
//        
//        let filteredComments = thread.comments.filter { $0.ownerUid == uid }
//        
//        for var comment in filteredComments {
//            if let commentOwner = try? await UserService.fetchUser(withUid: comment.ownerUid) {
//                comment.user = commentOwner
//            }
//        }
//        
//        if !filteredComments.isEmpty {
//            let pair = ThreadCommentPair(thread: thread, comments: filteredComments)
//            threadCommentPairs.append(pair)
//        }
//    }
//    return threadCommentPairs
//}
