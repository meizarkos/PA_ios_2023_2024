//
//  stringManager.swift
//  PA_ios_2023_2024
//
//  Created by Etudiant on 01/06/2024.
//

import Foundation

func removeLastCharacters(from string:String,number:Int)->String{
    let offset = number * -1
    let endIndex = string.index(string.endIndex,offsetBy:offset)
    let newString = String(string[..<endIndex])
    return newString
}
