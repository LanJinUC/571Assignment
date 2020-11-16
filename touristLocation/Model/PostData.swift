//
//  PostData.swift
//  H4X0R News
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return name
    }
    let name: String
    let price: String
    let score: String
    let link: String
    let thumbnail_image: String

}
