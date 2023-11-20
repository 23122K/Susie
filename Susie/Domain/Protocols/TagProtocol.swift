//
//  TagProtocol.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import SwiftUI

protocol Tag: RawRepresentable, CaseIterable, Hashable, Codable {
    var description: String { get }
    var color: Color { get }
}
