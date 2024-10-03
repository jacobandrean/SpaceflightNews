//
//  AuthManager.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 02/10/24.
//

import Auth0
import Foundation
import UtilityModule

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @KeychainStored(key: "credentials") var credentials: Credentials?
    var profile: UserProfile?
    
    func login(completion: @escaping (Bool) -> Void) {
        Auth0
            .webAuth()
            .start { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let credentials):
                    self.credentials = credentials
                    consoleLog(.info, message: credentials.accessToken)
                    consoleLog(.info, message: self.credentials?.accessToken)
                    completion(true)
                    self.fetchProfile()
                case .failure(let error):
                    consoleLog(.error, message: error)
                    completion(false)
                }
            }
    }
    
    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    consoleLog(.succeed, message: "Logged out")
                case .failure(let error):
                    consoleLog(.error, message: error)
                }
            }
    }
    
    func fetchProfile() {
        guard let credentials else { return }
        Auth0
            .authentication()
            .userInfo(withAccessToken: credentials.accessToken)
            .start { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let userInfo):
                    consoleLog(.succeed, message: userInfo)
                    self.profile = .init(name: userInfo.name, email: userInfo.email)
                case .failure(let error):
                    consoleLog(.error, message: error)
                }
            }
    }
}
