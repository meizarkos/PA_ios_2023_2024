//
//  AccueilViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

class AccueilViewController: UIViewController {
    
    @IBOutlet weak var numberOfTicket: UILabel!
    @IBOutlet weak var leaveNumber: UILabel!
    @IBOutlet weak var companyToValid: UILabel!
    @IBOutlet weak var teamActive: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        self.navigationItem.hidesBackButton = true
        
        let request = request(url: "allAdminData", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let adminData = json as? [String:Int] else{return}
            
            DispatchQueue.main.async {
                self.numberOfTicket.text = "Ticket to solve : \(adminData["ticketNumber"] ?? 0)"
                self.leaveNumber.text = "Number of leave pending : \(adminData["leaveNumber"] ?? 0)"
                self.companyToValid.text = "Company waiting for validation : \(adminData["companyNumber"] ?? 0)"
                self.teamActive.text = "Team active : \(adminData["teamNumber"] ?? 0)"
            }
        }
        task.resume()
    }
    
    @IBAction func ticketView(_ sender: Any) {
        createVC(goTo: UnsolvedTicketsViewController(), actu: self)
    }
    
    @IBAction func leaveView(_ sender: Any) {
        createVC(goTo: LeaveViewController(), actu: self)
    }
    
    @IBAction func companyView(_ sender: Any) {
        createVC(goTo: CompanyViewController(), actu: self)
    }
    
    @IBAction func teamView(_ sender: Any) {
        createVC(goTo: TeamViewController(),actu: self)
    }
    
    @IBAction func deco(_ sender: Any) {
        exit(1)
    }
    
    static func newInstance()->AccueilViewController{
        let accueilVC = AccueilViewController()
        accueilVC.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        return accueilVC
    }
    
}
