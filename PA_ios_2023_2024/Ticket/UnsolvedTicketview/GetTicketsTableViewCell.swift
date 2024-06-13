//
//  GetTicketsTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

class GetTicketsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var description1: UILabel!
    
    func reload(with ticket:Ticket){
        title.text = ticket.title
        description1.text = ticket.description
        
    }
}
