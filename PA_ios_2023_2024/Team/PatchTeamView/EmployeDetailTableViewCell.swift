//
//  EmployeDetailTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 03/06/2024.
//

import UIKit

class EmployeDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var ticket_solved: UILabel!
    @IBOutlet weak var finition: UITextView!
    
    func reload(with employe:Employe){
        intro.text = "\(employe.lastName) \(employe.firstName)"
        ticket_solved.text = "Has solved \(employe.ticketSolved) tickets"
        finition.text = "Located at \(employe.location).\nThis person is \(employe.role) and can be contact at \(employe.email).\n He/She has worked for us since \(removeLastCharacters(from: employe.createdAt, number: 5))"
    }
}
