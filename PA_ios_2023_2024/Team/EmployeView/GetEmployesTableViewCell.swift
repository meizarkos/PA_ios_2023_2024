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
    @IBOutlet weak var slider: UISwitch!
    var uuid:String=""
    var param_team = ""
    
    
    func reload(with employe:Employe){
        slider.isOn = false
        lastAndFirstName.text = "\(employe.lastName) \(employe.firstName)"
        date.text = "Employe since \(removeLastCharacters(from:employe.createdAt,number:5))"
        uuid = employe.uuid
        if let isHere = employe.is_in_the_team {
            self.param_team = isHere
            if(isHere == "true"){
                slider.isOn = true
            }
        }
        else{
            self.param_team = ""
        }
    }
    
    func is_in_the_false(sender:UISwitch){
        if(sender.isOn){
            storeEmployeToAdd.listEmploye.employeToAdd.append(uuid)
            self.backgroundColor = UIColor.lightGray
        }
        else{
            storeEmployeToAdd.listEmploye.employeToAdd.removeAll{$0 == uuid}
            self.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func addOrDelete(_ sender: UISwitch) {
        if(self.param_team == ""){
            is_in_the_false(sender: sender)
        }
        else{
            if(self.param_team == "true"){
                if(!sender.isOn){
                    storeEmployeToAdd.listEmploye.employeToDelete.append(uuid)
                    self.backgroundColor = UIColor.blue
                }
                else{
                    storeEmployeToAdd.listEmploye.employeToDelete.removeAll{$0 == uuid}
                    self.backgroundColor = UIColor.white
                }
            }
            else{
                is_in_the_false(sender: sender)
            }
        }
    }
    
}
