//
//  ProtectedRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol ProtectedRepository {
    var authenticationInterceptor: any AuthenticationInterceptor { get }
}
