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
    
    func fetchUsers() {
        
        var userName: String = ""
        var access: String = ""
        var currentUser: Bool = false
        var userTournament: String = ""
        
        database.collection("Users").addSnapshotListener { (querySnapshot, err) in
            
            if let err = err {
                print("ERROR \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let documentData = document.data()
                    
                    
                    userName = documentData["UserName"] as? String ?? ""
                    access = documentData["Access"] as? String ?? ""
                    currentUser = documentData["Current User"] as? Bool ?? false
                    userTournament = documentData["User Tournament"] as? String ?? ""
                    
                    self.users.append(User(userName: userName, access: access, tournamentName: userTournament, currentUser: currentUser))
                    
                }
            }
        }
        
        
    }
    
    func addAllUsers(users: [User]) {
        for user in users {
            addUser(user: user)
        }
    }
}

