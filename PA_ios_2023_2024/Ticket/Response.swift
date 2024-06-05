//
//  Response.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 05/06/2024.
//

import Foundation

class Response{
    var response_id:String
    var description:String
    var status:String
    var createdAt:String
    var updatedAt:String
    var creatorId:String
    var ticketId:String

    init(response_id: String,description:String,status:String, createdAt:String,updatedAt:String,creatorId:String,ticketId:String) {
        self.response_id = response_id
        self.description = description
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.creatorId = creatorId
        self.ticketId = ticketId
    }

    static func fromJSON(dict: [String:Any]) -> Response?{
        guard let response_id = (dict["uuid"] as? String),
              let description = (dict["description"] as? String),
              let status = (dict["status"] as? String),
              let createdAt = (dict["created_at"] as? String),
              let updatedAt = (dict["updated_at"] as? String),
              let creatorId = (dict["creator_id"] as? String),
              let ticketId = (dict["ticket_id"] as? String)
        else{
            return nil
        }
        
        
        return Response(response_id: response_id, description: description, status: status, createdAt: createdAt, updatedAt: updatedAt, creatorId: creatorId, ticketId: ticketId)
    }
}
