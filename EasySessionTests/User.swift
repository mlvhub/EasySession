//
//  User.swift
//  EasySession
//
//  Created by Lopez Valenciano, Miguel on 5/25/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import Foundation
import EasySession

struct User: SessionMappable {
    
    let id: Int
    let email: String
    let name: String
    
    init(id: Int, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
    }
    
    static func keys() -> [String] {
        return [
            "id",
            "email",
            "name"
        ]
    }
    
    func toDictionary() -> [String: String] {
        return [
            "id": "\(self.id)",
            "email": self.email,
            "name": self.name
        ]
    }
    
    init(dictionary: [String: String]) {
        self.id = Int(dictionary["id"]!)!
        self.email = String(UTF8String: dictionary["email"]!)!
        self.name = String(UTF8String: dictionary["name"]!)!
    }
}