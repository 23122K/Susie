//
//  RequestInterceptor.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation

protocol RequestInterceptor {
    func intercept(request: URLRequest) async throws -> URLRequest
}
