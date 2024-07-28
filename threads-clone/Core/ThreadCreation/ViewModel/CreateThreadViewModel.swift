//
//  CreateThreadViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 15.07.24.
//

import Firebase
import SwiftUI
import PhotosUI

class CreateThreadViewModel: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: [], comments: [], repostedBy: [])
        try await ThreadService.uploadThread(thread)
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
}
