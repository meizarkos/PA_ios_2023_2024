//
//  HomeViewController.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 24/04/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func connexion(_ sender: Any) {
        let url = URL(string: "https://helpother.fr/loginAdmin")!
        let body = ["email":emailValue.text!,"password":passwordValue.text!]
        
        guard let JSONbody = try? JSONSerialization.data(withJSONObject: body) else{return}
            
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = JSONbody
                
                let task = URLSession.shared.dataTask(with: request) { data, response, err in
                    
                    guard err == nil else{return}
                    guard let dataIsNotNull = data else{return}
                    
                    guard let json = try? JSONSerialization.jsonObject(with: dataIsNotNull) else{return}
                    
                    
                    guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else{
                        
                        let answer = json as? [String : String]
                        
                        DispatchQueue.main.async{
                            self.errorMessage.text = answer?["message"]!
                        }
                        return
                    }
                    
                    guard let answerSuccess = json as? [String : String] else {return}
                    
                    //guard let UserRes = ParseUser.fromJSON(dict: resSuccess.user) else{return}
                    
                    DispatchQueue.main.async {
                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appdelegate.token = answerSuccess["token"]
                        
                        self.navigationController?.pushViewController(UnsolvedTicketsViewController(), animated: true)
                        
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
