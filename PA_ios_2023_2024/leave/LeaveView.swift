//
//  LeaveView.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 07/06/2024.
//

import Foundation

class LeaveView{
    var employe:Employe
    var leave:Leave
    var teams:[Team]?
    
    init(employe:Employe,leave:Leave,teams:[Team]?){
        self.employe = employe
        self.leave = leave
        self.teams = teams
    }
    
    static func fromJSON(dict: [String:Any]) -> LeaveView?{
        guard let employe = (dict["employe"] as? [String:Any]),
              let leave = (dict["leave"] as? [String:Any])
        else{
            return nil
        }
        let teams = (dict["team"] as? [[String:Any]])
        
        let resEmploye:Employe
        let resLeave:Leave
        let resTeams:[Team]?
        
        resEmploye = Employe.fromJSON(dict: employe)!
        resLeave = Leave.fromJSON(dict: leave)!
        resTeams = teams?.compactMap(Team.fromJSON(dict:))
        
        
        return LeaveView(employe: resEmploye, leave: resLeave,teams:resTeams)
    }
}
