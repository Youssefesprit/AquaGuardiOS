//
//  PostCardView.swift
//  Aqua Guard
//
//  Created by Youssef Farhat on 29/11/2023.
//

import SwiftUI

struct PostCardView: View {
    let post: PostModel
    @State private var isLiked = false
    @State private var likeCount: Int = 0
    @State private var commentText: String = ""
    init(post: PostModel) {
        self.post = post
        // Initialize the likeCount state with the initial like count of the post
        _likeCount = State(initialValue: post.nbLike)
    }
    
    
    var body: some View {
        let commentCount: Int = post.nbComments
        
        // MaterialCardView equivalent in SwiftUI is a VStack inside a RoundedRectangle
        VStack(alignment: .leading, spacing: 2) {
            // User info and post image
            HStack {
                
                AsyncImage(url: URL(string: "http://127.0.0.1:9090/images/user/\(post.userImage ?? "")")) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable() // Make the image resizable
                            .aspectRatio(contentMode: .fill) // Fill the frame while maintaining aspect ratio
                    case .failure(_):
                        Image(systemName: "photo") // A fallback image in case of failure
                            .foregroundColor(.gray)
                    case .empty:
                        ProgressView() // An activity indicator while the image is loading
                    @unknown default:
                        EmptyView() // A default view for unknown phase
                    }
                }
                .frame(width: 65, height: 65) // Set the frame size for the image
                .clipShape(Circle()) // Clip the image to a circle
                .overlay(Circle().stroke(Color.darkBlue, lineWidth: 2)) // Add a border around the image

                // User name and role
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.userName)
                        .font(.title2)
                    Text(post.userRole)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(16)
                Spacer()
                NavigationLink( destination: PostDetailView(post: post)) {
                    Image(systemName:"info.circle").foregroundColor(.blue)
                  
                }
            }
            Divider()
                .background(Color.darkBlue)
            
            // Post description
            Text(post.description)
                .padding(16)
                .foregroundColor(.secondary)
            
            //  i want ti center this image
            AsyncImage(url: URL(string: "http://127.0.0.1:9090/images/post/\(post.postImage)")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable() // Make the image resizable
                        .aspectRatio(contentMode: .fit) // Fit the content in the current view size
                        .frame(height: 200) // Set the frame height
                        .frame(maxWidth: .infinity, alignment: .center) // Set the frame width to be as wide as possible and align it to the center
                case .failure(_):
                    Image(systemName: "photo") // An image to display in case of failure to load
                        .foregroundColor(.gray)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity, alignment: .center)
                case .empty:
                    ProgressView() // An activity indicator until the image loads
                        .frame(height: 200)
                        .frame(maxWidth: .infinity, alignment: .center)
                @unknown default:
                    EmptyView() // Default view in case of unknown phase
                }
            }
            .padding(.bottom) // Add some padding at the bottom

            
            Divider()
                .background(Color.darkBlue)
            
            
            HStack {
                // Like icon with label and count
               
                    Button(action: {
                        // Toggle the isLiked state
                        self.isLiked.toggle()
                        if self.isLiked {
                            self.likeCount += 1
                        
                        } else {
                            self.likeCount -= 1
                        }
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .pink : .pink)
                        Text("Like \(self.likeCount)").foregroundStyle(Color.black)
                    }
                    .padding(.trailing, -6)
                    
                    
               
                
                // this don't want to chage their
                Spacer()
                
                Image(systemName: commentCount > 0 ? "text.bubble.fill" : "text.bubble")
                    .foregroundColor(commentCount > 0 ? .yellow : .yellow )
                    .padding(.trailing, -6)
                Text("Comment \(commentCount)")
                
                Spacer()
                
                
                // Share icon with label and count
                Image(systemName: "square.and.arrow.up") .foregroundColor(Color("babyBlue"))
                    .padding(.trailing, -6)
                Text("Share 0")
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            
            
            
            
            Divider()
                .background(Color.darkBlue)
            
            HStack {
                // Text field for the comment
                TextField("Add your comment", text:$commentText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1)) // Light gray background
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                // Send button
                Button(action: {
                    // Handle send comment action
                    // TODO: Implement the action
                }) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20) // Adjust size of the icon
                       .padding(10)
                }
                .background(Color.blue) // Use a more appealing color
                .foregroundColor(.white) // White color for the icon
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 1)
                )
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 8)
            
            
            VStack(spacing: 8) {
                ForEach(post.comments.prefix(2) ?? [],id: \.idComment) { comment in
                    CommentCardView(comment: comment)
                }
                
                if post.comments.count > 2 {
                    Divider()
                        .background(Color.darkBlue)
                        HStack {
                          
                            Spacer() // Pushes the content to center
                            Text("...")
                                .foregroundColor(Color.darkBlue)
                            NavigationLink(destination: PostDetailView(post: post)) {
                                Text("View more")
                                    .foregroundColor(.darkBlue)
                            }
                            Spacer() // Pushes the content to center
                        }
                    }
            }
            .padding(.vertical, 5)
            
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        
        .cornerRadius(8)
        .shadow(radius: 4)
       // .padding(5)
    }
    
    
}
struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.darkBlue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
#Preview {
    PostCardView(post: post1) // is this correct ?
        .previewLayout(.sizeThatFits)
}
