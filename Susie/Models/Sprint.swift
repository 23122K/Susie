//
//  Sprint.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//
import Foundation

struct Sprint: Identifiable, Codable {
    let id: Int32
    let name: String
    let startTime: Date?
    let projectID: Int32
    let active: Bool
    
    init(name: String, projectID: Int32, startTime: Date? = nil, active: Bool = false) {
        self.id = -1
        self.name = name
        self.projectID = projectID
        self.startTime = startTime
        self.active = active
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        //As custom date decoding strategy cannot decode NULL value nor return nil if founds one
        //try container.decodeIfPresent has been changed to below line
        //in case of invalid data (not probable) or NULL value it will set nill to startTime insted of throwin an error
        self.startTime = try? container.decode(Date.self, forKey: .startTime)
        self.projectID = try container.decode(Int32.self, forKey: .projectID)
        self.active = try container.decode(Bool.self, forKey: .active)
    }
}
