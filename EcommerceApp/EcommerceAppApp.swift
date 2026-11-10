//
//  EcommerceAppApp.swift
//  EcommerceApp
//
//  Created by Mohit  on 07/11/26.
//

import SwiftUI

@main
struct EcommerceAppApp: App {
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
        }
    }
}
