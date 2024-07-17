//
//  ContentViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 11.07.24.
//

import Foundation
import Combine
import Firebase

class ContenetViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
