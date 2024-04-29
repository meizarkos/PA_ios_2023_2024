//
//  TeamViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class TeamViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var teamTableView: UITableView!
    var teams : [Team] = []
    var token:String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.teams.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = self.teams[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TEAMS_CELL_ID", for: indexPath) as! GetTeamsTableViewCell
        
        cell.reload(with: team )
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "GetTeamsTableViewCell", bundle: nil)
        self.teamTableView.register(cellNib, forCellReuseIdentifier: "TEAMS_CELL_ID")
        self.teamTableView.dataSource = self
        self.teamTableView.delegate = self

        fetchTeam()
    }
    
    func fetchTeam(){
        let url = URL(string: "https://helpother.fr/employeTeam")!
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allTeams = json as? [[String:Any]] else{return}
            
            let teams = allTeams.compactMap(Team.fromJSON(dict:))
            
            self.teams = teams
            
            DispatchQueue.main.async {
                self.teamTableView.reloadData()
            }
        }
        task.resume()
    }
    
    @IBAction func createTeam(_ sender: Any) {
        self.navigationController?.pushViewController(CreateTeamViewController(), animated: true)
    }
}


