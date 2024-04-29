//
//  CreateTeamViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class CreateTeamViewController: UIViewController {

    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var teamName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorName.text=""
    }
    
    

    @IBAction func `continue`(_ sender: Any) {
        if(teamName.text?.count ?? 0>128){
            errorName.text = "Name is too long"
            return
        }
        if(teamName.text == ""){
            errorName.text = "Team name is required"
            return
        }
        let destination = AddEmployeViewController(teamName:teamName.text!)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
