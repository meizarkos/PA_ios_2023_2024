//
//  AddEmployeViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit


class storeEmployeToAdd {
    static let listEmploye = storeEmployeToAdd()
    var employeToAdd:[String] = []
    var employeToDelete:[String] = []

    private init(){}
    
    func getChain(tab:[String])->String{
        let chaine = tab.joined(separator: ",")
        return chaine
    }
    
}

class AddEmployeViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var employeTableView: UITableView!
    var teamName:String
    
    var  employes: [Employe] = []
    var token:String?
    
    init(teamName:String){
        self.teamName=teamName
        super.init(nibName: nil, bundle: nil)
        storeEmployeToAdd.listEmploye.employeToAdd = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

        fetchEmploye()
    }
    
    func fetchEmploye(){
        let url = URL(string: "https://helpother.fr/employe")!
        
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
        var url = URL(string: "https://helpother.fr/team")!
        var teamId:String=""
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appdelegate.token
        
        let body = ["team_name": self.teamName]
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = JSONbody
        
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
        let chaineToAdd:String = singletonChain.getChain(tab: singletonChain.employeToAdd)
        url=URL(string: "https://helpother.fr/employeTeam/\(teamId)?ids=\(chaineToAdd)&idsDelete=")!
        
        var add = URLRequest(url: url)
        add.httpMethod = "POST"
        add.setValue("BEARER \(self.token!)", forHTTPHeaderField: "Authorization")
        add.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let addEmploye = URLSession.shared.dataTask(with: add) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(TeamViewController(), animated: true)
            }
        }
        addEmploye.resume()
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