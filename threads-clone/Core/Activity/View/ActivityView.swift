//
//  ActivityView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let user: User
    
    @StateObject var viewModel = ActivityViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            
                        } label: {
                            Text("All")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                .frame(width: 130, height: 43)
                                .background(colorScheme == .dark ? Color.white : Color.black)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray2))
                                }
                        }
                        Button {
                            
                        } label: {
                            Text("Replies")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                .frame(width: 130, height: 43)
                                .background(colorScheme == .light ? Color.white : Color.black)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(colorScheme == .light ? Color(.systemGray4) : Color(.systemGray2))
                                }
                        }
                    }
                    .padding()
                    
                    ForEach(viewModel.users) { user in
                        ActivityCell(user: user)
                    }
                }
            }
            .navigationTitle("Activity")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(user: dev.user)
    }
}
