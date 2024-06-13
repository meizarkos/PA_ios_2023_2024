//
//  EmployeDetailTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 03/06/2024.
//

import UIKit

class EmployeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var finition: UITextView!
    
    func reload(with employe:Employe){
        finition.layer.cornerRadius = 10
        finition.text = "Employe : \(employe.lastName) \(employe.firstName)\nTicket solved : \(employe.ticketSolved)\n\nLocated at \(employe.location).\nThis person is \(employe.role) and can be contact at \(employe.email).\n He/She has worked for us since \(removeLastCharacters(from: employe.createdAt, number: 14))"
    }
}
