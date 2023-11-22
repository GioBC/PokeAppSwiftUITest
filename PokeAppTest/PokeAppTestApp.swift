//
//  PokeAppTestApp.swift
//  PokeAppTest
//
//  Created by Giovanny Beltran on 16/11/23.
//

import SwiftUI

@main
struct PokeAppTestApp: App {
    
    @State private var isActive = false
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if isActive {
                PokemonListView()
            } else {
                SplashView(isActive: $isActive)
            }
        }
    }
}
