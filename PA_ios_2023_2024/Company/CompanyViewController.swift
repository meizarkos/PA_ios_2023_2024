//
//  CompanyViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 31/05/2024.
//

import UIKit

class CompanyViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var companiesTableView: UITableView!
    var companies:[Company] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.companies.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = self.companies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "COMPANIES_CELL_ID", for: indexPath) as! GetCompanyTableViewCell
        
        cell.reload(with: company)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = DetailCompanyViewController.newInstance(company: self.companies[indexPath.row])
        
        reloadVC(next: next, actu: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "GetCompanyTableViewCell", bundle: nil)
        self.companiesTableView.register(cellNib, forCellReuseIdentifier: "COMPANIES_CELL_ID")
        self.companiesTableView.dataSource = self
        self.companiesTableView.delegate = self
        fetchCompany()
    }
    
    func fetchCompany(){
        
        let request = request(url: "banCompanies", verb: "GET")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else{return}
            guard let dataIsNotNull = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
            
            guard let allCompanies = json as? [[String:Any]] else{return}
            
            let companies = allCompanies.compactMap(Company.fromJSON(dict:))
            
            self.companies = companies
            
            print(companies)
            
            DispatchQueue.main.async {
                self.companiesTableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCompany()
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
