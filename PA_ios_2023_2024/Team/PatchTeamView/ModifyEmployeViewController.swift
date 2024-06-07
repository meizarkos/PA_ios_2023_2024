//
//  ModifyEmployeViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 03/06/2024.
//

import UIKit

class ModifyEmployeViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var team:Team!
    var employes:[Employe] = []
    @IBOutlet weak var employeTableView: UITableView!
    
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
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
        
        let cellNib = UINib(nibName: "GetEmployesTableViewCell", bundle: nil)
        self.employeTableView.register(cellNib, forCellReuseIdentifier: "EMPLOYES_CELL_ID")
        self.employeTableView.dataSource = self
        self.employeTableView.delegate = self
        
        fetchEmployeWithStatus()
    }
    
    func fetchEmployeWithStatus(){
        
        let request = request(url: "statusTeam/\(team.uuid)", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let response = json as? [[String:Any]] else{return}
            
            let employes = response.compactMap(Employe.fromJSON(dict:))
            
            self.employes = employes
            
            DispatchQueue.main.async {
                self.employeTableView.reloadData()
            }
        }
        task.resume()
        
    }

    @IBAction func add(_ sender: Any) {
        let request = request(url: "employeTeam/\(team.uuid)?ids=\(getChain(tab: storeEmployeToAdd.listEmploye.employeToAdd))&idsDelete=\(getChain(tab: storeEmployeToAdd.listEmploye.employeToDelete))", verb: "POST")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard (try? JSONSerialization.jsonObject(with: dataIsNotNull)) != nil else{return}
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(TeamViewController(), animated: true)
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployeWithStatus()
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
    }
    
    static func newInstance(team:Team)->ModifyEmployeViewController{
        let modifEmployeVC = ModifyEmployeViewController()
        modifEmployeVC.team = team
        storeEmployeToAdd.listEmploye.employeToAdd = []
        storeEmployeToAdd.listEmploye.employeToDelete = []
        return modifEmployeVC
    }
}
