//
//  UserViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 27/11/2021.
//

import FirebaseFirestore


class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var currentUser = User(userName: "", email: "", access: "", tournamentName: "", eventNames: [])
    
    private var database = Firestore.firestore()
    
    
    func addUser(user: User) {
        
        let _ = database.collection("Users").document("\(user.userName)").setData([
            
            "UserName" : user.userName,
            "Email" : user.email,
            "Access" : user.access,
            "User Tournament" : user.tournamentName,
            "User Events" : user.eventNames,
            "Current User" : user.currentUser
            
        ])
    }
    
    
    func addCurrentUser(user: User) {
        
        let _ = database.collection("Users").document("Current User").setData([
            
            "UserName" : user.userName,
            "Email" : user.email,
            "Access" : user.access,
            "User Tournament" : user.tournamentName,
            "User Events" : user.eventNames,
            "Current User" : user.currentUser
            
        ])
    }
    
    
    func fetchUsers() {
        
        var userName: String = ""
        var email: String = ""
        var access: String = ""
        var userTournament: String = ""
        var userEvents: [String] = []
        var currentUser: Bool = false
        
        database.collection("Users").addSnapshotListener { (querySnapshot, err) in
            
            if let err = err {
                print("ERROR \(err)")
            } else {
                DispatchQueue.main.async {
                    self.users = querySnapshot!.documents.map { document -> User in
                        
                        
                            userName = document["UserName"] as? String ?? ""
                            email = document["Email"] as? String ?? ""
                            access = document["Access"] as? String ?? ""
                            userTournament = document["User Tournament"] as? String ?? ""
                            userEvents = document["User Events"] as? [String] ?? []
                            currentUser = document["Current User"] as? Bool ?? false
                            
                            
                        return User(userName: userName, email: email, access: access, tournamentName: userTournament, eventNames: userEvents, currentUser: currentUser)
                        
                    }
                    self.users.removeAll(where: { $0.userName == "REMOVE CURRENT USER" })
                }
            }
        }
    }
    
    
    func fetchCurrentUser() {
        
        var userName: String = ""
        var email: String = ""
        var access: String = ""
        var userTournament: String = ""
        var userEvents: [String] = []
        var currentUser: Bool = false
        
        database.collection("Users").document("Current User").addSnapshotListener { documentSnapshot, err in
            guard let document = documentSnapshot else {
                print("Error \(err!)")
                return
            }
            guard let data = document.data() else {
                print("Document was empty")
                return
            }
            
            userName = data["UserName"] as? String ?? ""
            email = document["Email"] as? String ?? ""
            access = document["Access"] as? String ?? ""
            userTournament = document["User Tournament"] as? String ?? ""
            userEvents = document["User Events"] as? [String] ?? []
            currentUser = document["Current User"] as? Bool ?? false
            
            self.currentUser = User(userName: userName, email: email, access: access, tournamentName: userTournament, eventNames: userEvents, currentUser: currentUser)
            
        }
    }
    
    func addAllUsers(users: [User]) {
        for user in users {
            addUser(user: user)
        }
    }
}

