//
//  UserContentListViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import Combine
import Firebase
import FirebaseFirestoreSwift

class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var comments = [Comment]()
    @Published var threadCommentPairs = [ThreadCommentPair]()
    
    let user: User
    let comment: Comment
    private var threadListener: ListenerRegistration?
    private var commentListener: ListenerRegistration?
    
    init(user: User, comment: Comment) {
        self.user = user
        self.comment = comment
        fetchInitialData()
        setupListeners()
    }
    
    private func fetchInitialData() {
        Task {
            try await fetchUserThreads()
            try await fetchThreadsWithComments()
        }
    }
    
    private func setupListeners() {
        let db = Firestore.firestore()
        
        threadListener = db.collection("threads").addSnapshotListener { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let snapshot = snapshot {
                for diff in snapshot.documentChanges {
                    switch diff.type {
                    case .added, .modified, .removed:
                        Task {
                            try await self.fetchUserThreads()
                        }
                    }
                }
            }
        }
        
        commentListener = db.collection("comments").addSnapshotListener { [weak self] (snapshot, error) in
                    guard let self = self else { return }
                    if let snapshot = snapshot {
                        for diff in snapshot.documentChanges {
                            switch diff.type {
                            case .added, .modified, .removed:
                                Task {
                                    try await self.fetchThreadsWithComments()
                                }
                            }
                        }
                    }
                }
    }
    
    
    deinit {
        threadListener?.remove()
        commentListener?.remove()
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
//    func listenForComments(threadId: String) {
//        commentListener?.remove()
//        commentListener = Firestore
//            .firestore()
//            .collection("threads")
//            .document(threadId)
//            .collection("comments")
//            .addSnapshotListener { snapshot, error in
//                guard let documents = snapshot?.documents else {
//                    print("No documents in collection")
//                    return
//                }
//                self.comments = documents.compactMap { try? $0.data(as: Comment.self) }
//                self.updateThreadCommentPairs()
//            }
//    }
//    
//    private func updateThreadCommentPairs() {
//        for (index, pair) in threadCommentPairs.enumerated() {
//            if let thread = pair.thread {
//                threadCommentPairs[index].comments = comments.filter { $0.threadId == thread.id }
//            }
//        }
//    }
    
    @MainActor
    func fetchThreadsWithComments() async throws {
        var pairs = try await ThreadService.fetchThreadsWithComments(uid: user.id)
        
        for index in 0 ..< pairs.count {
            for commentIndex in 0 ..< pairs[index].comments.count {
                pairs[index].comments[commentIndex].user = self.user
            }
        }
        
        self.threadCommentPairs = pairs
//        self.threads = pairs.map { $0.thread }
        self.comments = pairs.flatMap { $0.comments }
    }
}
//
//@MainActor
//func fetchUserThreads() async throws {
//    var threads = try await ThreadService.fetchUserThreads(uid: user.id)
//    
//    for i in 0 ..< threads.count {
//        threads[i].user = self.user
//    }
//    self.threads = threads
//}
//
//@MainActor
//func fetchComments() async throws {
//    var pairs = try await ThreadService.fetchThreadsWithComments(uid: user.id)
//    
//    for index in 0 ..< pairs.count {
//        for commentIndex in 0 ..< pairs[index].comments.count {
//            pairs[index].comments[commentIndex].user = self.user
//        }
//    }
//    
//    self.threadCommentPairs = pairs
////        self.threads = pairs.map { $0.thread }
//    self.comments = pairs.flatMap { $0.comments }
//}
