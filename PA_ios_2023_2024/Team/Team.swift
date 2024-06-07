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
              let teamName = (dict["team_name"] as? String),
              let createdAt = (dict["created_at"] as? String),
              let updatedAt = (dict["updated_at"] as? String)
        else{
            return nil
        }
        
        let numberOfEmploye = (dict["number_of_employe"] as? Int)
        
        return Team(uuid: uuid, teamName:teamName, numberOfEmploye:numberOfEmploye,createdAt: createdAt, updatedAt: updatedAt)
    }
}

