//
//  Team.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on
//
//  Ticket.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import Foundation

class Team {
    
    var uuid:String
    var teamName : String
    var numberOfEmploye:Int?
    var createdAt:String
    var updatedAt:String
    
    init(uuid: String,teamName:String,numberOfEmploye:Int?,createdAt:String,updatedAt:String) {
        self.uuid = uuid
        self.teamName = teamName
        self.numberOfEmploye = numberOfEmploye
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func fromJSON(dict: [String:Any]) -> Team?{
        guard let uuid = (dict["uuid"] as? String),
              let teamName = (dict["teamName"] as? String),
              let createdAt = (dict["createdAt"] as? String),
              let updatedAt = (dict["updatedAt"] as? String),
              let numberOfEmploye = (dict["numberOfEmploye"] as? Int)
        else{
            return nil
        }
        
        
        return Team(uuid: uuid, teamName:teamName, numberOfEmploye:numberOfEmploye,createdAt: createdAt, updatedAt: updatedAt)
    }
}

