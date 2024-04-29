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
    var RIB:String
    var location:String
    var role:String
    var ticketSolved:Int
    var numberOfDaysOff:Int
    var createdAt:String
    var updatedAt:String
    
    init(uuid: String,email:String,firstName:String,lastName:String,RIB:String,location:String,role:String,ticketSolved:Int,numberOfDaysOff:Int,createdAt:String,updatedAt:String) {
        self.uuid = uuid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.RIB = RIB
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
              let firstName = (dict["firstName"] as? String),
              let lastName = (dict["lastName"] as? String),
              let RIB = (dict["RIB"] as? String),
              let location = (dict["location"] as? String),
              let role = (dict["role"] as? String),
              let ticketSolved = (dict["ticketSolved"] as? Int),
              let numberOfDaysOff = (dict["numberOfDaysOff"] as? Int),
              let createdAt = (dict["createdAt"] as? String),
              let updatedAt = (dict["updatedAt"] as? String)
        else{
            return nil
        }
        
        
        return Employe(uuid: uuid, email:email,firstName:firstName,lastName:lastName,RIB:RIB,location:location,role:role,ticketSolved:ticketSolved,numberOfDaysOff:numberOfDaysOff, createdAt: createdAt, updatedAt: updatedAt)
    }
}
