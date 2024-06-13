//
//  DetailLeaveViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import UIKit

class DetailLeaveViewController: UIViewController {
    
    var leaveView:LeaveView!
    @IBOutlet weak var leaveName: UILabel!
    @IBOutlet weak var bigDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigDescription.layer.cornerRadius = 10
        bigDescription.layer.masksToBounds = true
        
        var textTeam:String = ""
        
        let employe = leaveView.employe
        let leave = leaveView.leave
        
        if let team = leaveView.teams{
            textTeam = "His team are/is:"
            for eachTeam in team{
                textTeam += " \(eachTeam.teamName)"
            }
        }
        else{
            textTeam = "He/She isn't in any team"
        }
        
        leaveName.text = "\(employe.lastName) \(employe.firstName)"
        
        bigDescription.text = "The employe \(employe.lastName) \(employe.firstName)\nwho has worked for us since \(removeLastCharacters(from: employe.createdAt, number: 14))\nand has a status of \(employe.role), would like to go on vacation.\n\n\(textTeam)\n\nHe would like to leave on \(removeLastCharacters(from:leave.start_date, number: 14))\nand come back on \(removeLastCharacters(from: leave.end_date, number: 14))\n\n\n\nLeave date : \(removeLastCharacters(from: leave.start_date, number: 14))\n\nReturn \(removeLastCharacters(from: leave.end_date, number: 14)) \n\nFor employe : \(employe.lastName) \(employe.firstName)"
        
    }
    
    func patchLeave(value:Any){
        let request = requestWithBody(url: "leave/\(leaveView.leave.leave_id)", verb: "PATCH", body: ["status":value])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard (try? JSONSerialization.jsonObject(with: dataIsNotNull)) != nil else{return}
            
            DispatchQueue.main.async {
                createVC(goTo: LeaveViewController(), actu: self)
            }
        }
        task.resume()
        
    }
    
    @IBAction func allow(_ sender: Any) {
        let alert = UIAlertController(title: "Valider \(leaveView.employe.lastName) \(leaveView.employe.firstName) to leave ?", message: "The date are from \(removeLastCharacters(from: leaveView.leave.start_date, number: 14)) to \(removeLastCharacters(from: leaveView.leave.end_date, number: 14))", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Sure", style: .default){ _ in
            self.patchLeave(value: "allow")
        }
        let noAction = UIAlertAction(title: "Review before", style: .default){_ in alert.dismiss(animated: true)}
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func refuse(_ sender: Any) {
        let alert = UIAlertController(title: "Refuse \(leaveView.employe.lastName) \(leaveView.employe.firstName) to leave ?", message: "The date are from \(removeLastCharacters(from: leaveView.leave.start_date, number: 14)) to \(removeLastCharacters(from: leaveView.leave.end_date, number: 14))", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Sure", style: .default){ _ in
            self.patchLeave(value: "refuse")
        }
        let noAction = UIAlertAction(title: "Review before", style: .default){_ in alert.dismiss(animated: true)}
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert,animated: true,completion: nil)
    }
    
    
    static func newInstance(leaveView:LeaveView)->DetailLeaveViewController{
        let detailVC = DetailLeaveViewController()
        detailVC.leaveView = leaveView
        return detailVC
    }

}
