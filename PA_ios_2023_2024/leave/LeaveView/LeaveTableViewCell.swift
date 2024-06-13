//
//  LeaveTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import UIKit

class LeaveTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bigDescription: UILabel!
    
    func reload(with leaveView:LeaveView){
        
        let employe = leaveView.employe
        let leave = leaveView.leave
        
        let start_text = removeLastCharacters(from: leave.end_date, number: 14)
        let end_text = removeLastCharacters(from: leave.start_date, number: 14)
        
        bigDescription.text = "From employe :\n\(employe.lastName) \(employe.firstName)\nwant to leave.\nFrom:\n\(start_text)\nTo:\n\(end_text)\n"
    }
    
}
