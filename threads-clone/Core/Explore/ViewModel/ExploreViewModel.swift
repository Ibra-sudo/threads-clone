//
//  ExploreViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
