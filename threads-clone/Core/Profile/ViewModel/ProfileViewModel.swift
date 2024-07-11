//
//  ProfileViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 11.07.24.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User view model from combine is \(user)")
        }.store(in: &cancellables)
    }
}
