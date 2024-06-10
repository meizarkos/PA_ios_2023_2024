//
//  GetTicketsTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

class GetTicketsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var payload: UITextView!
    @IBOutlet weak var fromDate: UILabel!
    
    
    func reload(with ticket:Ticket){
        title.text = ticket.title
        payload.text = ticket.description
        fromDate.text = "from \(ticket.creatorId) at \(removeLastCharacters(from:ticket.createdAt,number: 5))"
    }
}
