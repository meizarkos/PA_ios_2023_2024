//
//  Company.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 31/05/2024.
//

import Foundation

class Company {
    
    var uuid:String
    var email : String
    var company_name:String
    var phone:String?
    var siret_number:String
    var location:String
    var role:String
    var created_at:String
    var updated_at:String
    
    init(uuid:String,
    email : String,
    company_name:String,
    phone:String?,
    siret_number:String,
    location:String,
    role:String,
    created_at:String,
    updated_at:String) {
        self.uuid = uuid
        self.email = email
        self.company_name = company_name
        self.phone = phone
        self.siret_number = siret_number
        self.location = location
        self.role = role
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    static func fromJSON(dict: [String:Any]) -> Company?{
        guard let uuid = (dict["uuid"] as? String),
              let email = (dict["email"] as? String),
              let company_name = (dict["company_name"] as? String),
              let siret_number = (dict["siret_number"] as? String),
              let location = (dict["location"] as? String),
              let role = (dict["role"] as? String),
              let created_at = (dict["created_at"] as? String),
              let updated_at = (dict["updated_at"] as? String),
              let phone = (dict["phone"] as? String?)
        else{
            return nil
        }
        
        
        return Company(uuid: uuid, email: email, company_name: company_name, phone: phone, siret_number: siret_number, location: location, role: role, created_at: created_at, updated_at: updated_at)
    }
}
