//
//  Binding+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import SwiftUI

public extension Binding {
    static func convert<TInt, TFloat>(from intBinding: Binding<TInt>) -> Binding<TFloat> where TInt: BinaryInteger, TFloat: BinaryFloatingPoint {
        Binding<TFloat> (get: { TFloat(intBinding.wrappedValue) }, set: { intBinding.wrappedValue = TInt($0) })
    }
}
