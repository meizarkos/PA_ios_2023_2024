//
//  Ticket.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import Foundation

class Ticket {
    
    var ticketId:String
    var title : String
    var description:String
    var status:Int
    var createdAt:String
    var updatedAt:String
    var creatorId:String
    
    init(ticketId: String,title:String,description:String,status:Int, createdAt:String,updatedAt:String,creatorId:String) {
        self.ticketId = ticketId
        self.title = title
        self.description = description
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.creatorId = creatorId
    }
    
    static func fromJSON(dict: [String:Any]) -> Ticket?{
        guard let ticketId = (dict["uuid"] as? String),
              let title = (dict["title"] as? String),
              let description = (dict["description"] as? String),
              let status = (dict["status"] as? Int),
              let createdAt = (dict["created_at"] as? String),
              let updatedAt = (dict["updated_at"] as? String),
              let creatorId = (dict["creator_id"] as? String)
        else{
            return nil
        }
        
        
        return Ticket(ticketId: ticketId, title: title, description: description, status: status, createdAt: createdAt, updatedAt: updatedAt, creatorId: creatorId)
    }
}
