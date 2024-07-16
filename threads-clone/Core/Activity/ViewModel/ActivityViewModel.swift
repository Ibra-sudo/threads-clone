//
//  ActivityViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import Foundation

class ActivityViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
