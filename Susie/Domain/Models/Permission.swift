//
//  Permission.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import Foundation

struct ChangePermissionRequest: Codable {
    let projectID: Int32
    let userUUID: String
    let roleName: String
}
