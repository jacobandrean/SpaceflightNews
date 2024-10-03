//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeVM = NewsViewModel()
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            if authVM.isAuthenticated {
                HomeView()
                    .environmentObject(homeVM)
            } else {
                AuthView()
                    .environmentObject(authVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
