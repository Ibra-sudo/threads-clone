//
//  LoginViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 11.07.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
