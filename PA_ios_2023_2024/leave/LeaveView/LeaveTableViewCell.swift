//
//  LeaveTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import UIKit

class LeaveTableViewCell: UITableViewCell {

    @IBOutlet weak var bigDescription: UITextView!
    
    func reload(with leaveView:LeaveView){
        bigDescription.layer.cornerRadius = 10
        bigDescription.layer.masksToBounds = true
        
        var textTeam:String = ""
        
        let employe = leaveView.employe
        let leave = leaveView.leave
        
        if let team = leaveView.teams{
            textTeam = "His team are/is:"
            for eachTeam in team{
                textTeam += " \(eachTeam.teamName)"
            }
        }
        else{
            textTeam = "He/She isn't in any team"
        }
        
        bigDescription.text = "The employe \(employe.lastName) \(employe.firstName) who has worked for us since \(removeLastCharacters(from: employe.createdAt, number: 5)) and has a status of \(employe.role), would like to go on vacation.\n\n\(textTeam)\n\nHe would like to leave on \(removeLastCharacters(from:leave.start_date, number: 14)) and come back on \(removeLastCharacters(from: leave.end_date, number: 14))"
    }
    
}
