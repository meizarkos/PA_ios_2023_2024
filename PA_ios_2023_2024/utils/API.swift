//
//  API.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 31/05/2024.
//

import Foundation
import UIKit

func request(url:String,verb:String)->URLRequest{
    let url = URL(string: "https://helpother.fr/\(url)")!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let token = appdelegate.token
    
    
    var request = URLRequest(url: url)
    request.httpMethod = verb
    request.setValue("BEARER \(token!)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}

func requestWithBody(url:String,verb:String,body:[String:Any])->URLRequest{
    let url = URL(string: "https://helpother.fr/\(url)")!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let token = appdelegate.token
    
    
    let JSONbody = try? JSONSerialization.data(withJSONObject:body)
    
    var request = URLRequest(url: url)
    request.httpMethod = verb
    request.setValue("BEARER \(token!)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = JSONbody
    return request
}


