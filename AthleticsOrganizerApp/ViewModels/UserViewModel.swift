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
}
