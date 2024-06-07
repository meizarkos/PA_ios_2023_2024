//
//  Leave.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import Foundation

class Leave {
    var leave_id:String
    var id_employe : String
    var start_date:String
    var end_date:String
    var status:String
    var createdAt:String
    var updatedAt:String
    
    init(leave_id: String,id_employe:String,start_date:String,end_date:String,status:String, createdAt:String,updatedAt:String) {
        self.leave_id = leave_id
        self.id_employe = id_employe
        self.start_date = start_date
        self.end_date = end_date
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func fromJSON(dict: [String:Any]) -> Leave?{
        guard let leave_id = (dict["uuid"] as? String),
              let id_employe = (dict["id_employe"] as? String),
              let start_date = (dict["start_date"] as? String),
              let end_date = (dict["end_date"] as? String),
              let status = (dict["status"] as? String),
              let createdAt = (dict["created_at"] as? String),
              let updatedAt = (dict["updated_at"] as? String)
        else{
            return nil
        }
        
        
        return Leave(leave_id: leave_id, id_employe: id_employe, start_date: start_date, end_date: end_date, status: status, createdAt: createdAt, updatedAt: updatedAt)
    }
}
