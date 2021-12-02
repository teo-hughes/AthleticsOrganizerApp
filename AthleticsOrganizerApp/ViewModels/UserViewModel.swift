//
//  UserViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 27/11/2021.
//

import FirebaseFirestore


class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    private var database = Firestore.firestore()
    
    func addUser(user: User) {
        
        let _ = database.collection("Users").document("\(user.userName)").setData([
            
            "UserName" : user.userName,
            "Access" : user.access,
            "Current User" : user.currentUser,
            "User tournament" : user.tournamentName
            
        ])
    }
}

