//
//  GetEmployesTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class GetEmployesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lastAndFirstName: UILabel!
    @IBOutlet weak var date: UILabel!
    var uuid:String=""
    
    
    func reload(with employe:Employe){
        lastAndFirstName.text = "\(employe.lastName) \(employe.firstName)"
        date.text = "Employe since \(removeLastCharacters(from:employe.createdAt,number:5))"
        uuid = employe.uuid
    }
    
    @IBAction func addOrDelete(_ sender: UISwitch) {
        if(sender.isOn){
            storeEmployeToAdd.listEmploye.employeToAdd.append(uuid)
            self.backgroundColor = UIColor.lightGray
        }
        else{
            storeEmployeToAdd.listEmploye.employeToAdd.removeAll{$0 == uuid}
            self.backgroundColor = UIColor.white
        }
    }
    
}
