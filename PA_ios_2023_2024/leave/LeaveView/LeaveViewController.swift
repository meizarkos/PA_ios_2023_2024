//
//  LeaveViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import UIKit

class LeaveViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var all:[LeaveView] = []
    @IBOutlet weak var leaveTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.all.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaveView = self.all[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LEAVE_CELL_ID", for: indexPath) as! LeaveTableViewCell
        
        cell.reload(with: leaveView)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = DetailLeaveViewController.newInstance(leaveView: self.all[indexPath.row])
        
        reloadVC(next: next, actu: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "LeaveTableViewCell", bundle: nil)
        self.leaveTableView.register(cellNib, forCellReuseIdentifier: "LEAVE_CELL_ID")
        self.leaveTableView.dataSource = self
        self.leaveTableView.delegate = self
        
        fetchLeaveView()
    }
    
    func fetchLeaveView(){
        
        let request = request(url: "pendingLeaveAllData", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allData = json as? [[String:Any]] else{return}
            
            let all = allData.compactMap(LeaveView.fromJSON(dict:))
            
            self.all = all
            
            DispatchQueue.main.async {
                self.leaveTableView.reloadData()
            }
        }
        task.resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchLeaveView()
    }
}
