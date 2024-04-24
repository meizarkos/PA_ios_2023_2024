//
//  UnsolvedTicketsViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

class UnsolvedTicketsViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource{
    
   
    @IBOutlet weak var ticketTableView: UITableView!
    var tickets : [Ticket] = []
    var token:String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.tickets.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = self.tickets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TICKETS_CELL_ID", for: indexPath) as! GetTicketsTableViewCell
        
        cell.reload(with: ticket )
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "GetTicketsTableViewCell", bundle: nil)
        self.ticketTableView.register(cellNib, forCellReuseIdentifier: "TICKETS_CELL_ID")
        self.ticketTableView.dataSource = self
        self.ticketTableView.delegate = self

        fetchTicket()
    }
    
    func fetchTicket(){
        let url = URL(string: "https://helpother.fr/unsolvedTickets")!
        
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
            
            guard let allTickets = json as? [[String:Any]] else{return}
            
            let tickets = allTickets.compactMap(Ticket.fromJSON(dict:))
            
            self.tickets = tickets
            
            DispatchQueue.main.async {
                self.ticketTableView.reloadData()
            }
        }
        task.resume()
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
