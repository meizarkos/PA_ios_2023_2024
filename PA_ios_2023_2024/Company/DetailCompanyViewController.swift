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
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var textData: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.company_name.text = company.company_name
        if let phone = company.phone{
            self.phone.text = "Contact phone : \(phone)"
        }
        else{
            self.phone.text = "No phone provided"
        }
        self.email.text = "Email : \(company.email)"
        self.textData.text = "The companie enter the SIRET NUMBER : \(company.siret_number).\n\n It is located at \(company.location). \n\n It has created his account on \(removeLastCharacters(from: company.created_at,number: 5)). \n If you think these data are correct you can validate the company. Thus allowing it to post his announce."
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
                self.navigationController?.pushViewController(CompanyViewController(), animated: true)
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
