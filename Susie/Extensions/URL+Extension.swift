//
//  URL+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/08/2023.
//

import Foundation

extension URL {
    var asNSString: NSString {
        return self.absoluteString as NSString
    }
}
