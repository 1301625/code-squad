//
//  Cube.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/08.
//

import Foundation

enum Action : String {
    case U, R, L, B
    case Usquoted = "U'"
    case Rsquotud = "R'"
    case Lsquoted = "L'"
    case Bsquoted = "B'"
    
    func toString() -> String {
        switch self {
        case .Bsquoted : return "B'"
        case .Lsquoted : return "L'"
        case .Usquoted : return "U'"
        case .Rsquotud : return "R'"
        default:
            return self.rawValue
        }
    }
}

struct Cube {
    
    var cube : [[String]]
    
    init() {
        cube = [["R","R","W"],
                ["G","C","W"],
                ["G","B","B"]]
    }
    
    mutating func leftPush(cube piece : [String]) -> [String] {
        let index = 1
        return Array(piece[index..<piece.count] + piece[0..<index])
    }
    
    mutating func rightPush(cube piece : [String]) -> [String] {
        let index = 2
        return Array(piece[index..<piece.count] + piece[0..<index])
    }
    
    mutating func upPush(column : Int){
        var cubeArray = flatColumn(column)
        cubeArray = leftPush(cube: cubeArray)
        replaceCube(temp: cubeArray, column)
    }
    
    mutating func downPush(column : Int){
        var cubeArray = flatColumn(column)
        cubeArray = rightPush(cube: cubeArray)
        replaceCube(temp: cubeArray, column)
    }
    
    func flatColumn(_ column : Int) -> [String] {
        var change = [String]()
        for i in 0...2 {
            change.append(cube[i][column])
        }
        return change
    }
    
    mutating func replaceCube(temp : [String] ,_ column : Int) {
        for i in 0...2 {
            cube[i][column] = temp[i]
        }
    }
    
    mutating func process(input : [Action]) {
        print()
        input.forEach { (action) in
            print(action.toString())
            switch action {
            case .U:
                cube[0] = leftPush(cube: cube[0])
            case .R:
                upPush(column : 2)
            case .L:
                downPush(column: 0)
            case .B:
                cube[2] = rightPush(cube: cube[2])
            case .Usquoted:
                cube[0] = rightPush(cube: cube[0])
            case .Rsquotud:
                downPush(column: 2)
            case .Lsquoted:
                upPush(column: 0)
            case .Bsquoted:
                cube[2] = leftPush(cube: cube[2])
            }
            cubePrint()
        }
    }
    
    func cubePrint(){
        for i in 0...2 {
            for j in 0...2 {
                print(cube[i][j], separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
}

