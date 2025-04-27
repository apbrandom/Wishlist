//
//  WishModel.swift
//  Wishlist
//
//  Created by Vadim Vinogradov on 4/27/25.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
