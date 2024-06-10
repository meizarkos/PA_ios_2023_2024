//
//  CreateResponseViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 05/06/2024.
//

import UIKit

class CreateResponseViewController: UIViewController {
    
    var ticket:Ticket!
    @IBOutlet weak var ticketTitle: UILabel!
    @IBOutlet weak var ticketDescription: UILabel!
    @IBOutlet weak var responseValue: UITextField!
    @IBOutlet weak var errorValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorValue.text = ""
        ticketTitle.text = ticket.title
        ticketTitle.layer.cornerRadius = 15
        ticketTitle.layer.masksToBounds = true
        
        ticketDescription.layer.cornerRadius = 10
        ticketDescription.layer.masksToBounds = true
        ticketDescription.text = "\n \(ticket.description)\n Created at \(removeLastCharacters(from:ticket.createdAt,number:5))\n"
    }
    
    
    func newInstance(ticket:Ticket)->CreateResponseViewController{
        let createResVC = CreateResponseViewController()
        createResVC.ticket = ticket
        return createResVC
    }
    
    func postResponse(){
        
        let body : [String:Any] = ["description":responseValue.text!,"status":"admin"]
        
        let request = requestWithBody(url: "responseAdmin/\(ticket.ticketId)", verb: "POST", body: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard (try? JSONSerialization.jsonObject(with: dataIsNotNull)) != nil else{return}
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(UnsolvedTicketsViewController(), animated: true)
            }
        }
        task.resume()
    }
    
    
    @IBAction func postResponse(_ sender: Any) {
        if(responseValue.text == ""){
            errorValue.text = "Empty response arent allowed"
            return
        }
        let alert = UIAlertController(title: "Is \(responseValue.text!) what you want to send?", message: "The description was \(ticket.description)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes I am sure", style: .default){ _ in
            self.postResponse()
        }
        let noAction = UIAlertAction(title: "I want to review it", style: .default){_ in alert.dismiss(animated: true)}
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert,animated: true,completion: nil)
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
