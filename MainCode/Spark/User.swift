//
//  User.swift
//  MainCode
//
//  Created by Sora suu on 5/6/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var email: String?
    var profileImageUrl : String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
    override init() {
    
    }
}
