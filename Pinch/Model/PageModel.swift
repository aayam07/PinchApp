//
//  PageModel.swift
//  Pinch
//
//  Created by Aayam Adhikari on 06/08/2023.
//

import Foundation

extension Page {
    // computed property
    var thumbnailName: String {
        return "thumb-" + imageName  // string concatenation
    }
}

struct Page: Identifiable {
    // let constants are created as these values are not changed
    
    let id: Int  // helps to differentiate different images
    let imageName: String
}

