//
//  ExploreViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import Foundation
import Combine

class ExploreViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var filteredUsers = [User]()
    @Published var searchText = "" {
        didSet {
//            print("Search text changed to: \(searchText)")
            filterUsers()
        }
    }
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
        self.filteredUsers = users
    }
    
    
    private func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.fullname.lowercased().hasPrefix(searchText.lowercased()) }
        }
//        print("Filtered users: \(filteredUsers.map { $0.username })")
    }
}
