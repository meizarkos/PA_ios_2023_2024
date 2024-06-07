//
//  tabManager.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 03/06/2024.
//

import Foundation

func getChain(tab:[String])->String{
    let chaine = tab.joined(separator: ",")
    return chaine
}


class storeEmployeToAdd {
    static let listEmploye = storeEmployeToAdd()
    var employeToAdd:[String] = []
    var employeToDelete:[String] = []

    private init(){}
}

