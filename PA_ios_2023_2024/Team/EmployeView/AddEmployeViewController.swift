//
//  AddEmployeViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class AddEmployeViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var employeTableView: UITableView!
    var teamName:String!
    
    var  employes: [Employe] = []
    var token:String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employes.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employe = self.employes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMPLOYES_CELL_ID", for: indexPath) as! GetEmployesTableViewCell
        
        cell.reload(with: employe)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "GetEmployesTableViewCell", bundle: nil)
        self.employeTableView.register(cellNib, forCellReuseIdentifier: "EMPLOYES_CELL_ID")
        self.employeTableView.dataSource = self
        self.employeTableView.delegate = self
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
        fetchEmploye()
    }
    
    func fetchEmploye(){
        let request = request(url: "employe", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let response = json as? [String:Any] else{return}
            
            guard let allEmployes = response["items"] as? [[String:Any]] else {return}
            
            let employes = allEmployes.compactMap(Employe.fromJSON(dict:))
            
            self.employes = employes
            
            DispatchQueue.main.async {
                self.employeTableView.reloadData()
            }
        }
        task.resume()
    }

    @IBAction func addEmploye(_ sender: Any) {
        let semaphore = DispatchSemaphore(value: 0)
        var teamId:String=""
        
        let request = requestWithBody(url: "team", verb: "POST", body: ["team_name": self.teamName as String])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            defer{
                semaphore.signal()
            }
            
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let response = json as? [String:Any] else{return}
            guard let item = response["item"] as? [String:String] else {return}
            teamId = item["uuid"]!
        }
        task.resume()
        semaphore.wait()
        
        let singletonChain:storeEmployeToAdd = storeEmployeToAdd.listEmploye
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        let url=URL(string: "https://helpother.fr/employeTeam/\(teamId)?ids=\(getChain(tab: singletonChain.employeToAdd))&idsDelete=")!
        
        var add = URLRequest(url: url)
        add.httpMethod = "POST"
        add.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        add.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        
        let addEmploye = URLSession.shared.dataTask(with: add) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard (try? JSONSerialization.jsonObject(with: dataIsNotNull)) != nil else{return}
            
            DispatchQueue.main.async {
                createVC(goTo: TeamViewController(), actu: self)
            }
        }
        addEmploye.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEmploye()
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
    }
    
    static func newInstance(teamName:String)->AddEmployeViewController{
        let addEmployeVC = AddEmployeViewController()
        addEmployeVC.teamName = teamName
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
        return addEmployeVC
    }
}
