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
        self.navigationController?.pushViewController(UnsolvedTicketsViewController(), animated: true)
    }
    
    @IBAction func leaveView(_ sender: Any) {
        self.navigationController?.pushViewController(LeaveViewController(), animated: true)
    }
    
    @IBAction func companyView(_ sender: Any) {
        self.navigationController?.pushViewController(CompanyViewController(), animated: true)
    }
    
    @IBAction func teamView(_ sender: Any) {
        let splitVC = UISplitViewController()
        
        splitVC.viewControllers = [TeamViewController(),UIViewController()]
        
        let tabBarControl = UITabBarController()
    
        tabBarControl.viewControllers = [
            splitVC,
        ]
        
        self.navigationController?.pushViewController(tabBarControl, animated: true)
    }
    
    @IBAction func deco(_ sender: Any) {
        exit(1)
    }
    
}
