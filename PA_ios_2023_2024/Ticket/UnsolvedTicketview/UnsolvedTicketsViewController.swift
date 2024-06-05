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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = ResponseViewController.newInstance(ticket:self.tickets[indexPath.row])
        
        if let splitVC = self.splitViewController {
            if splitVC.isCollapsed {
                self.navigationController?.pushViewController(next, animated: true)
            }
            else{
                if let detailNavController = splitVC.viewControllers.last as? UINavigationController {
                    detailNavController.setViewControllers([next], animated: true)
                }
                else{
                    splitVC.showDetailViewController(UINavigationController(rootViewController: next), sender: self)
                }
            }
        }
        else if self.navigationController != nil {
            self.navigationController?.pushViewController(next, animated: true)
        }
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
        
        let request = request(url: "unsolvedTickets", verb: "GET")
        
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
