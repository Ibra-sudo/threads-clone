//
//  UserContentListView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI
import Firebase

struct UserContentListView: View {
    
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    // to resizable width of the phone screen
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    init(user: User, comment: Comment) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user, comment: comment))
    }
    
    var body: some View {
        // user content list view
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .light)
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.primary)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation) // to make move on as smothy animation and we need property name: Namespace to do this animation
                        } else {
                            Divider()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            switch selectedFilter {
            case .threads:
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        ThreadCell(thread: thread)
                    }
                }
            case .replies:
                LazyVStack {
                    ForEach(viewModel.threadCommentPairs, id: \.thread.id) { pair in
                        ForEach(pair.comments, id: \.id) { comment in
                            RepliesThreadView(thread: pair.thread, comment: comment)
                        }
//                        if let firstComment = pair.comments.first {
//                        RepliesThreadView(thread: pair.thread, comment: firstComment)
//                            } else {
//                                // Handle the case where there are no comments, if necessary
//                                // For example, you could show a placeholder view or a message
//                                RepliesThreadView(thread: pair.thread, comment: nil)
//                            }
                    }
                }
            case .reposts:
                LazyVStack {
                    ForEach(1 ..< 10, id: \.self) { thread in
                        Text("Reposts")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                    }
                }
            }
        }
        .padding(.horizontal, 5)
        .onAppear {
            Task {
                try await viewModel.fetchUserThreads()
                try await viewModel.fetchThreadsWithComments()
            }
        }
    }
}

struct UserContentListView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentListView(user: dev.user, comment: dev.comment)
    }
}
