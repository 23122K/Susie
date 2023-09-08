//
//  Container.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import Foundation
import Factory

extension Container {
    var client: Factory<Client> {
        self { Client() }
            .singleton
    }
}
