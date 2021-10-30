//
//  Post.swift
//  StaggeredTab
//
//  Created by 공현택 on 2021/10/30.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
