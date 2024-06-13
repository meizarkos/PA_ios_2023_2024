//
//  DetailCompanyViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 01/06/2024.
//

import UIKit

class DetailCompanyViewController: UIViewController {
    
    var company:Company!

    
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var textData: UITextView!
    var email:String = ""
    var phone:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textData.layer.cornerRadius = 10
        textData.layer.masksToBounds = true
        self.company_name.text = company.company_name
        if let phone = company.phone{
            self.phone = "Contact phone : \(phone)"
        }
        else{
            self.phone = "No phone provided"
        }
        self.email = "Email : \(company.email)"
        self.textData.text = "The companie enter the SIRET NUMBER : \(company.siret_number).\n\nIt is located at \(company.location).\n\n\(email)\n\(phone)\n\nIt has created his account on \(removeLastCharacters(from: company.created_at,number: 14)). \n\nIf you think these data are correct you can validate the company. Thus allowing it to post his announce."
    }
    
    static func newInstance(company:Company)->DetailCompanyViewController{
        let companyViewController = DetailCompanyViewController()
        companyViewController.company = company
        return companyViewController
    }
    
    
    func patchCompany(){
        let request = requestWithBody(url: "companies/\(company.uuid)", verb: "PATCH", body: ["role":"validated"])
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard (try? JSONSerialization.jsonObject(with: dataIsNotNull)) != nil else{return}
            
            DispatchQueue.main.async {
                createVC(goTo: CompanyViewController(), actu: self)
            }
        }
        task.resume()
    }

    @IBAction func validateCompany(_ sender: Any) {
        let alert = UIAlertController(title: "Valider \(company.company_name) ?", message: "Are you sure you want to allow \(company.siret_number) in the website ?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Sure", style: .default){ _ in
            self.patchCompany()
        }
        let noAction = UIAlertAction(title: "Review before", style: .default){_ in alert.dismiss(animated: true)}
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert,animated: true,completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
