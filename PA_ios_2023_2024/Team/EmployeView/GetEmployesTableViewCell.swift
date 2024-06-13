//
//  GetEmployesTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class GetEmployesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var employeDesc: UITextView!
    @IBOutlet weak var slider: UISwitch!
    var uuid:String=""
    var param_team = ""
    
    
    func reload(with employe:Employe){
        slider.isOn = false
        employeDesc.layer.cornerRadius = 10
        employeDesc.text = "Employe : \(employe.lastName) \(employe.firstName)\nTicket solved : \(employe.ticketSolved)\n\nLocated at \(employe.location).\nThis person is \(employe.role) and can be contact at \(employe.email).\n He/She has worked for us since \(removeLastCharacters(from: employe.createdAt, number: 14))"
        uuid = employe.uuid
        if let isHere = employe.is_in_the_team {
            self.param_team = isHere
            if(isHere == "true"){
                slider.isOn = true
                self.backgroundColor = UIColor.lightGray
                employeDesc.backgroundColor = UIColor.gray
            }
            else{
                self.backgroundColor = UIColor.white
                employeDesc.backgroundColor = UIColor.systemGray4
            }
        }
        else{
            self.param_team = ""
            self.backgroundColor = UIColor.white
            employeDesc.backgroundColor = UIColor.systemGray4
        }
    }
    
    func is_in_the_false(sender:UISwitch){
        if(sender.isOn){
            storeEmployeToAdd.listEmploye.employeToAdd.append(uuid)
            self.backgroundColor = UIColor.lightGray
            employeDesc.backgroundColor = UIColor.gray
        }
        else{
            storeEmployeToAdd.listEmploye.employeToAdd.removeAll{$0 == uuid}
            self.backgroundColor = UIColor.white
            employeDesc.backgroundColor = UIColor.systemGray4
        }
    }
    
    @IBAction func change(_ sender: UISwitch) {
        if(self.param_team == ""){
            is_in_the_false(sender: sender)
        }
        else{
            if(self.param_team == "true"){
                if(!sender.isOn){
                    storeEmployeToAdd.listEmploye.employeToDelete.append(uuid)
                    self.backgroundColor = UIColor.white
                    employeDesc.backgroundColor = UIColor.systemGray4
                }
                else{
                    storeEmployeToAdd.listEmploye.employeToDelete.removeAll{$0 == uuid}
                    self.backgroundColor = UIColor.lightGray
                    employeDesc.backgroundColor = UIColor.gray
                }
            }
            else{
                is_in_the_false(sender: sender)
            }
        }
    }
    
}
