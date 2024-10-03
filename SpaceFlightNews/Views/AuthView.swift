//
//  AuthView.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    authVM.login()
                }) {
                    Text("Login with Auth0")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                Button(action: {
                    authVM.logout()
                }) {
                    Text("Logout with Auth0")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
        }
    }
}

//struct AuthView2: View {
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if isAuthenticated {
//                    // Authenticated User Screen
//                    VStack {
//                        Text("Welcome, \(profile?.name ?? "User")")
//                            .font(.title)
//
//                        Button(action: {
//                            logout()
//                        }) {
//                            Text("Log Out")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.red)
//                                .cornerRadius(8)
//                        }
//                    }
//                } else {
//                    // Unauthenticated User Screen (Login & Register)
//                    VStack {
//                        Text("Login or Register")
//                            .font(.largeTitle)
//                            .padding()
//
//                        Button(action: {
//                            login()
//                        }) {
//                            Text("Login with Auth0")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(8)
//                        }
//                        .padding(.top, 20)
//
//                        Button(action: {
//                            register()
//                        }) {
//                            Text("Register with Auth0")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(8)
//                        }
//                        .padding(.top, 10)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//
//    // Auth0 Login
//    func login() {
//        Auth0
//            .webAuth()
//            .useHTTPS() // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
//            .start { result in
//                switch result {
//                case .success(let credentials):
//                    print("Obtained credentials: \(credentials)")
//                case .failure(let error):
//                    print("Failed with: \(error)")
//                }
//            }
//    }
//
//    // Auth0 Register (Sign Up)
//    func register() {
//////        let values = plistValues(bundle: bundle)!
//////        return webAuth(clientId: values.clientId, domain: values.domain, session: session)
////        Auth0
////            .webAuth()
////            .scope("openid profile email")
//////            .audience("https://YOUR_DOMAIN/userinfo")
////            .parameters(["screen_hint": "signup"])  // Hint for signup screen
////            .start { result in
////                switch result {
////                case .success(let credentials):
////                    isAuthenticated = true
////                    fetchProfile(credentials: credentials)
////                case .failure(let error):
////                    print("Registration failed with: \(error)")
////                }
////            }
//
//        Auth0
//            .webAuth()
//            .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
//            .clearSession { result in
//                switch result {
//                case .success:
//                    print("Logged out")
//                case .failure(let error):
//                    print("Failed with: \(error)")
//                }
//            }
//    }
//
//    // Fetch User Profile after successful login/register
//    func fetchProfile(credentials: Credentials) {
////        Auth0
////            .authentication()
////            .userInfo(withAccessToken: credentials.accessToken!)
////            .start { result in
////                switch result {
////                case .success(let profile):
////                    self.profile = profile
////                case .failure(let error):
////                    print("Failed to fetch profile: \(error)")
////                }
////            }
//    }
//
//    // Auth0 Logout
//    func logout() {
//        Auth0
//            .webAuth()
////            .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
//            .clearSession { result in
//                switch result {
//                case .success:
//                    print("Logged out")
//                case .failure(let error):
//                    print("Failed with: \(error)")
//                }
//            }
//    }
//}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

