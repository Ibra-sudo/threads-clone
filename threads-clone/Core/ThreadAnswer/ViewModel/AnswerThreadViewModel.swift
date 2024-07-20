//
//  AnswerThreadViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 20.07.24.
//

import Firebase

class AnswerThreadViewModel: ObservableObject {
//    @Published var viewModel
    
    func uploadAnswer(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let answer = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: [], comments: [])
        try await ThreadService.uploadThread(answer)
    }
}
