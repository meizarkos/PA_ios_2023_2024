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
        
        fetchAdminData()
        
        
    }
    
    func fetchAdminData(){
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
        createVC(goTo: TeamViewController(), actu: self)
    }
    
    @IBAction func deco(_ sender: Any) {
        exit(1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAdminData()
    }
    
    static func newInstance()->AccueilViewController{
        
        let accueilVC = AccueilViewController()
        
        let Home = UINavigationController(rootViewController: AccueilViewController())
        UITabBar.appearance().tintColor = UIColor.black
        let barHome = UITabBarItem(title: "Home", image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home_selected"))
        barHome.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: 6, right: 0)
        barHome.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        Home.tabBarItem = barHome
        
        let Team : UINavigationController = goToSplitFromNavBar(goTo: TeamViewController(), name: "Teams", image: UIImage(named: "Team"), selectedImage: UIImage(named: "Team_selected"))
        let Companies = goToSplitFromNavBar(goTo: CompanyViewController(), name: "Companies", image: UIImage(named: "Usine"), selectedImage: UIImage(named: "Usine_selected"))
        let Leave = goToSplitFromNavBar(goTo: LeaveViewController(), name: "Leaves", image: UIImage(named: "Vacation"), selectedImage: UIImage(named: "Vacation_selected"))
        let Tickets = goToSplitFromNavBar(goTo: UnsolvedTicketsViewController(), name: "Tickets", image: UIImage(named: "Ticket"), selectedImage: UIImage(named: "Ticket_selected"))
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            Home,
            Leave,
            Tickets,
            Companies,
            Team,
        ]
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.window?.rootViewController = tabBarController
        
        return accueilVC
    }
    
}
