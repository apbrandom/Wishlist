//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Vadim Vinogradov on 4/27/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
