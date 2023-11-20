//
//  Array+Extensions.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation

extension Array where Element == IssueGeneralDTO {
    func with(status: IssueStatus) -> Array<IssueGeneralDTO> {
        self.filter { issue in
            issue.status == status
        }
    }
}
