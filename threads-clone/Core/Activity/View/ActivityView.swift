//
//  ActivityView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ActivityView: View {
    
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
                                .foregroundColor(.white)
                                .frame(width: 130, height: 43)
                                .background(.black)
                                .cornerRadius(10)
                        }
                        Button {
                            
                        } label: {
                            Text("Replies")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 130, height: 43)
                                .background(.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray4))
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
