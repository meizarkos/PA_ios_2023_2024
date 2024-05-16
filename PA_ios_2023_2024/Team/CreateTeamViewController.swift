//
//  CreateTeamViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 29/04/2024.
//

import UIKit

class CreateTeamViewController: UIViewController {

    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var teamName: UITextField!
    var token:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorName.text=""
    }
    
    

    @IBAction func `continue`(_ sender: Any) {
        if(teamName.text?.count ?? 0>128){
            errorName.text = "Name is too long"
            return
        }
        if(teamName.text == ""){
            errorName.text = "Team name is required"
            return
        }
        if(teamName.text == nil){
            errorName.text = "Team name is required"
            return
        }
        
        let url=URL(string:"https://helpother.fr/teamName/\(teamName.text!)")!
        
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
            
            guard let response = json as? [String:String] else{return}
            
            DispatchQueue.main.async {
                if(response["message"]=="Name is available"){
                    let destination = AddEmployeViewController(teamName:self.teamName.text!)
                    self.navigationController?.pushViewController(destination, animated: true)
                }
                else{
                    self.errorName.text = response["message"]
                }
            }
        }
        task.resume()
        
        
        
        
    }
}
