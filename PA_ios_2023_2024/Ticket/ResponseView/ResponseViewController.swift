//
//  ResponseViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 05/06/2024.
//

import UIKit

class ResponseViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ticketDescription: UILabel!
    @IBOutlet weak var ticketTitle: UILabel!
    var ticket:Ticket!

    @IBOutlet weak var responseTableView: UITableView!
    var responses:[Response] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.responses.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let response = self.responses[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RESPONSES_CELL_ID", for: indexPath) as! ResponseTableViewCell
        
        cell.reload(with:  response)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let response = self.responses[indexPath.row]
        return CGFloat(response.description.count*2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketTitle.text = ticket.title
        ticketTitle.layer.cornerRadius = 15
        ticketTitle.layer.masksToBounds = true
        
        ticketDescription.layer.cornerRadius = 10
        ticketDescription.layer.masksToBounds = true
        ticketDescription.text = "\n \(ticket.description)\n Created at \(removeLastCharacters(from:ticket.createdAt,number:5))\n"
        
        let cellNib = UINib(nibName: "ResponseTableViewCell", bundle: nil)
        self.responseTableView.register(cellNib, forCellReuseIdentifier: "RESPONSES_CELL_ID")
        self.responseTableView.dataSource = self
        self.responseTableView.delegate = self

        fetchResponse()
    }
    
    func fetchResponse(){
        let request = request(url: "responseTicket/\(ticket.ticketId)", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allResponse = json as? [[String:Any]] else{return}
            
            let responses = allResponse.compactMap(Response.fromJSON(dict:))
            
            self.responses = responses
            
            DispatchQueue.main.async {
                self.responseTableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchResponse()
    }

    static func newInstance(ticket : Ticket)->ResponseViewController{
        let responseVC = ResponseViewController()
        responseVC.ticket = ticket
        return responseVC
    }
    
    
    
    
    
    
    func patchTicket(){
        let request = requestWithBody(url: "tickets/\(ticket.ticketId)", verb: "PATCH", body: ["status":1])
        
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
    
    
    @IBAction func addAResponse(_ sender: Any) {
        let next = CreateResponseViewController().newInstance(ticket:ticket)
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func validateTheTicket(_ sender: Any) {
        
        let alert = UIAlertController(title: "Is \(ticket.title) solved?", message: "The description was \(ticket.description)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes it is solved", style: .default){ _ in
            self.patchTicket()
        }
        let noAction = UIAlertAction(title: "I want to review it", style: .default){_ in alert.dismiss(animated: true)}
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert,animated: true,completion: nil)
    }
}
