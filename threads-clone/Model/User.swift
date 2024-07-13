//
//  User.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 11.07.24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
