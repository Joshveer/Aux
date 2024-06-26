// UserManager.swift
// AuxRemake
//
// Created by Josh Grewal on 5/27/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import GoogleSignIn

struct DBUser {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    var musicAPIConnected = false
    let name: String?
    
}

final class UserManager {
    static let shared = UserManager()

    func createNewUser(googleUser: GIDGoogleUser, auth: AuthDataResultModel) async throws {

        var userData: [String:Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp(),
            "music_api_connected": auth.musicAPIConnected ?? false,
        ]

        if let email = auth.email {
            userData["email"] = email
        }

        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }

        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }

    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func getName() -> String? {
        return Auth.auth().currentUser?.displayName
    }

    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()

        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }

        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = (data["date_created"] as? Timestamp)?.dateValue()
        let musicAPIConnected = data["music_api_connected"] as? Bool ?? false
        let name = data["first_name"] as? String

        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated, musicAPIConnected: musicAPIConnected, name: name)
    }
}

// profile picture
// friends list
