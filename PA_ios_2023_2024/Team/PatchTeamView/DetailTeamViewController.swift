//
//  DetailTeamViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 01/06/2024.
//

import UIKit

class DetailTeamViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {

    var team:Team!
    @IBOutlet weak var team_name: UILabel!
    
    var employesOfTeam : [Employe] = []
    @IBOutlet weak var employeTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.employesOfTeam.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employe = self.employesOfTeam[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMPLOYES_TEAM_CELL_ID", for: indexPath) as! EmployeDetailTableViewCell
        
        cell.reload(with:employe)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team_name.text = team.teamName
        
        let cellNib = UINib(nibName: "EmployeDetailTableViewCell", bundle: nil)
        self.employeTableView.register(cellNib, forCellReuseIdentifier: "EMPLOYES_TEAM_CELL_ID")
        self.employeTableView.dataSource = self
        self.employeTableView.delegate = self

        fetchEmployeFromATeam()
    }
    
    func fetchEmployeFromATeam(){
        
        let request = request(url: "employeTeam/\(team.uuid)", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allEmployes = json as? [[String:Any]] else{return}
            
            let employes = allEmployes.compactMap(Employe.fromJSON(dict:))
            
            self.employesOfTeam = employes
            
            DispatchQueue.main.async {
                self.employeTableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployeFromATeam()
    }
    
    static func newInstance(team:Team)->DetailTeamViewController{
        let teamViewController = DetailTeamViewController()
        teamViewController.team = team
        return teamViewController
    }
    
    @IBAction func changeEmploye(_ sender: Any) {
        let next = ModifyEmployeViewController.newInstance(team:team)
        self.navigationController?.pushViewController(next, animated: true)
    }
}
