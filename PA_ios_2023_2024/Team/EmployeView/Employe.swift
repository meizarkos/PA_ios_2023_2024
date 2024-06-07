//
//  Employe.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import Foundation

class Employe {
    
    var uuid:String
    var email : String
    var firstName:String
    var lastName:String
    var RIB:String?
    var location:String
    var role:String
    var ticketSolved:Int
    var numberOfDaysOff:Int
    var createdAt:String
    var updatedAt:String
    var is_in_the_team:String?
    
    init(uuid: String,email:String,firstName:String,lastName:String,RIB:String?,is_in_the_team:String?,location:String,role:String,ticketSolved:Int,numberOfDaysOff:Int,createdAt:String,updatedAt:String) {
        self.uuid = uuid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.RIB = RIB
        self.is_in_the_team = is_in_the_team
        self.location = location
        self.role = role
        self.ticketSolved = ticketSolved
        self.numberOfDaysOff = numberOfDaysOff
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func fromJSON(dict: [String:Any]) -> Employe?{
        guard let uuid = (dict["uuid"] as? String),
              let email = (dict["email"] as? String),
              let firstName = (dict["first_name"] as? String),
              let lastName = (dict["last_name"] as? String),
              let location = (dict["location"] as? String),
              let role = (dict["role"] as? String),
              let ticketSolved = (dict["ticket_solved"] as? Int),
              let numberOfDaysOff = (dict["number_of_days_off"] as? Int),
              let createdAt = (dict["created_at"] as? String),
              let updatedAt = (dict["updated_at"] as? String)
        else{
            return nil
        }
        let RIB = (dict["rib"] as? String)
        let is_in_the_team = (dict["is_in_the_team"] as? String)
        
        return Employe(uuid: uuid, email:email,firstName:firstName,lastName:lastName,RIB:RIB,is_in_the_team: is_in_the_team,location:location,role:role,ticketSolved:ticketSolved,numberOfDaysOff:numberOfDaysOff, createdAt: createdAt, updatedAt: updatedAt)
    }
}
