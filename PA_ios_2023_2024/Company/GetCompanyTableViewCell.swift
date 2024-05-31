//
//  GetCompanyTableViewCell.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 31/05/2024.
//

import UIKit

class GetCompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var siret_number: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var creation: UILabel!
    
    
    func reload(with company:Company){
        company_name.text = company.company_name
        siret_number.text = "Siret number : \(company.siret_number)"
        if let phone = company.phone {
            self.phone.text = "Phone : \(phone)"
        }
        creation.text = company.created_at
    }
}
