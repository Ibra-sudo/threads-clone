//
//  CreateThreadViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 15.07.24.
//

import Firebase

class CreateThreadViewModel: ObservableObject {
    
//    @Published var caption = ""
    
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: [], comments: [])
        try await ThreadService.uploadThread(thread)
    }
}
