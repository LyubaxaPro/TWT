//
//  UserProfileManager.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//

import Foundation
import Firebase

protocol UserProfileManagerDescription : AnyObject {
    func getUserInfo(complition: @escaping (Result<UserProfileViewModel, Error>) -> Void)
    func getCityService(complition: @escaping (Result<String, Error>) -> Void)
    func changeUserData(userData: UserProfileViewModel, complition: @escaping (Bool) -> Void)
}

final class UserProfileManager: UserProfileManagerDescription {
    static let shared: UserProfileManagerDescription = UserProfileManager()
    init(){}

    func getUserInfo(complition: @escaping (Result<UserProfileViewModel, Error>) -> Void) {
        var userInfo: UserProfileViewModel = UserProfileViewModel(name: "", city: "")
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            if user != nil {
                let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()

                let groupsRef = ref.child("users/"+user!.uid + "/userInfo/")

                groupsRef.observeSingleEvent(of: .value)
                { (snapshot) in
                    guard let val = snapshot.value as? Dictionary<String, String> else {
                        complition(.failure(NetworkError.unexpected))
                        return
                    }
                    guard let name = val["name"] else {
                        complition(.failure(NetworkError.unexpected))
                        return
                    }

                    guard let city = val["city"] else {
                        complition(.failure(NetworkError.unexpected))
                        return
                    }
                    userInfo.name = name
                    userInfo.city = city
                    complition(.success(userInfo))
                }
            } else {
                complition(.failure(NetworkError.unexpected))
            }
        }
    }

    func getCityService(complition: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().addStateDidChangeListener { (auth, user)  in
            if user != nil {
                let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()

                let groupsRef = ref.child("users/"+user!.uid + "/userInfo/")

                groupsRef.observeSingleEvent(of: .value)
                { (snapshot) in
                    guard let val = snapshot.value as? Dictionary<String, String> else {
                        complition(.failure(NetworkError.unexpected))
                        return
                    }
                    guard let cityService = val["cityService"] else {
                        complition(.failure(NetworkError.unexpected))
                        return
                    }

                    complition(.success(cityService))
                }
            } else {
                complition(.failure(NetworkError.unexpected))
            }
        }
    }

    func changeUserData(userData: UserProfileViewModel, complition: @escaping (Bool) -> Void) {

        Auth.auth().addStateDidChangeListener { (auth, user)  in
            guard let user = user  else {
                complition(false)
                return
            }
            let uid = user.uid
            if uid.isEmpty {
                complition(false)
                return
            }

            let ref = Database.database(url: "https://eventtracker-3500c-default-rtdb.firebaseio.com/").reference()
            let cityService = ServiceData.shared.getCities()[userData.city] ?? ""
            let userInfo: [String : String] = ["name" : userData.name, "city" : userData.city, "cityService" : cityService]

            ref.child("users/" + uid  + "/userInfo/").setValue(userInfo)
            complition(true)
        }
    }
}
