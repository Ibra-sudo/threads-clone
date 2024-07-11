//
//  CircularProfileImageView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 10.07.24.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("max-moro")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
