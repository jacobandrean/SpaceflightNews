//
//  AuthViewModel.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 02/10/24.
//

import Auth0
import Combine
import Foundation

class AuthViewModel: ObservableObject {
    let authManager = AuthManager.shared
    @Published var isAuthenticated: Bool = false
    
    func login() {
        authManager.login { [weak self] isSuccess in
            self?.isAuthenticated = isSuccess
        }
    }
    
    func logout() {
        authManager.logout()
    }
}
