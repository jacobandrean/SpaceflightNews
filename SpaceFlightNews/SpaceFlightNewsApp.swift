//
//  SpaceFlightNewsApp.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import APIModule
import InjectorModule
import NetworkModule
import SwiftUI

@main
struct SpaceFlightNewsApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        injectDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            AuthView()
        }
    }

    private func injectDependencies() {
        let injector = Injector.shared
        
        injector.register(module: APIModule.Module())
        // TODO: should use keychain for security
//        let apiKey = "764292367668433"
//        let apiSecret = "7joFRwDGPx61FwsII7uEPqqamYE"
//        let credential = "\(apiKey):\(apiSecret)"
//        let credentialData = credential.data(using: .utf8)
//        let base64Credential = credentialData?.base64EncodedString() ?? ""
        
        let baseUrl = "https://api.spaceflightnewsapi.net"
        injector.register(
            AppServiceContext(
                urlString: baseUrl,
                defaultHeader: [:]
            ),
            for: ServiceContext.self
        )
    }
}
