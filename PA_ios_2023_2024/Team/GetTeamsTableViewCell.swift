//
//  GetTeamsTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class GetTeamsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var NumberDate: UILabel!
    @IBOutlet weak var created: UILabel!
    
    
    func reload(with team:Team){
        teamName.text = team.teamName
        NumberDate.text = "Compose of \(team.numberOfEmploye ?? 0) employe"
        created.text = "Since \(team.createdAt)"
    }
}
