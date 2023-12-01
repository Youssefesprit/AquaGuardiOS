//
//  PostViewModel.swift
//  Aqua Guard
//
//  Created by Youssef Farhat on 30/11/2023.
//

import Foundation
class PostViewModel : ObservableObject {
    @Published var posts :[Post]=[]
    private var likes: [String: Bool] = [:]
    private var likeCounts: [String: Int] = [:]
    
    init(){
        let post1 = Post(id: "p1", userName: "Youssef Farhat", userRole: "Partner", description: "Dive into the serene beauty of aquatic life with AquaGard! 🐠💧 Whether you're a seasoned aquarist or just starting your water gardening journey, our latest post offers a treasure trove of insights", userImage: "youssef", postImage: "post1", nbLike: 0, nbComments: 1, nbShare: 10, likes: [], comments: [comment1])

        let post2 = Post(id: "p2", userName: "Malek labidi", userRole: "partner", description: "🐢 Dive into the enchanting world of aquatic turtles! Explore their unique lifestyle and habitat in our latest post.", userImage: "user", postImage: "tortue", nbLike: 2, nbComments: 2, nbShare: 15, likes: [like1, like2], comments: [comment1, comment2])

        let post3 = Post(id: "p3", userName: "AlexSmith", userRole: "Traveler", description: "Exploring the world!", userImage: "yousseff", postImage: "tortue", nbLike: 1, nbComments: 1, nbShare: 20, likes: [like2], comments: [comment2])
        
         posts = [post1,post2,post3]
    }
    func toggleLike(for post: Post) {
           let isLiked = likes[post.id] ?? false
           likes[post.id] = !isLiked
           likeCounts[post.id] = (likeCounts[post.id] ?? 0) + (isLiked ? -1 : 1)
       }

       func isPostLiked(_ post: Post) -> Bool {
           likes[post.id] ?? false
       }

       func likeCount(for post: Post) -> Int {
           likeCounts[post.id] ?? 0
       }
}