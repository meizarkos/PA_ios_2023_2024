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
    
    func reload(with employe:Employe){
        lastAndFirstName.text = "\(employe.lastName) \(employe.firstName)"
        date.text = "Employe since \(employe.createdAt)"
    }
    
}
