//
//  ResponseTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 05/06/2024.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var me: UITextView!
    @IBOutlet weak var client: UITextView!
    
    func reload(with response:Response){
        if(response.status == "user"){
            client.text = response.description
            client.backgroundColor = UIColor.blue
            client.layer.cornerRadius = 10
            client.layer.masksToBounds = true
            me.text = ""
        }
        else{
            me.text = response.description
            me.layer.cornerRadius = 10
            me.layer.masksToBounds = true
            client.text = ""
            client.backgroundColor = UIColor.white
        }
    }
}
