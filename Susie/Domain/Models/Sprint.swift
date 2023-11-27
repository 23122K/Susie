//
//  Sprint.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//
import Foundation

struct Sprint: Identifiable, Codable {
    let id: Int32
    var name: String
    var goal: String
    var startTime: Date?
    var projectID: Int32
    var active: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case goal = "sprintGoal"
        case startTime
        case projectID
        case active
    }
    
    init(id: Int32, name: String, goal: String, startTime: Date? = nil, projectID: Int32, active: Bool) {
        self.id = id
        self.name = name
        self.goal = goal
        self.startTime = startTime
        self.projectID = projectID
        self.active = active
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.goal = try container.decode(String.self, forKey: .goal)
        
        //As custom date decoding strategy cannot decode NULL value nor return nil if founds one
        //try container.decodeIfPresent has been changed to below line
        //in case of invalid data (not probable) or NULL value it will set nill to startTime insted of throwin an error
        self.startTime = try? container.decode(Date.self, forKey: .startTime)
        self.projectID = try container.decode(Int32.self, forKey: .projectID)
        self.active = try container.decode(Bool.self, forKey: .active)
    }
}

extension Sprint {
    init(project: ProjectDTO) { self.init(id: .default, name: .default, goal: .default, projectID: project.id, active: .deafult) }
    
    var hasStartDate: Bool {
        self.startTime == nil ? false : true
    }
}
