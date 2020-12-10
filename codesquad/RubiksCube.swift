//
//  RubikCube.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/10.
//

import Foundation

enum Color : String {
    case B,W,O,G,Y,R
    
    init(num : Int) {
        switch num {
        case 0:
            self = .B
        case 1:
            self = .W
        case 2:
            self = .O
        case 3:
            self = .G
        case 4:
            self = .Y
        default:
            self = .R
        }
    }
}

struct RubiksCube {
    var cube : [[[String]]]
    
    init(){
        cube = Array(repeating: Array(repeating: Array(repeating: "", count: 3), count: 3), count: 6)
        
        for i in 0...5 {
            for j in 0...2 {
                cube[i][j] = Array(repeating: Color.init(num: i).rawValue, count: 3)
            }
        }
    }
    
    
    
    
    //MARK: 출력 부분
    func cubePrint() {
        sideCubePrint(side: 0)
        for i in 0...2 {
            middleCubePrint(floor: i)
        }
        print()
        sideCubePrint(side: 5)
    }
    
    func sideCubePrint(side : Int) {
        for j in 0...2 {
            print("\t\t\t\t ", separator : "" , terminator: "")
            for k in 0...2 {
                print(cube[side][j][k], separator: "" , terminator: " ")
            }
            print()
        }
        print()
    }
    
    func middleCubePrint(floor : Int) {
        for i in 1...4 {
            for k in 0...2 {
                print(cube[i][floor][k], separator : "" , terminator: " ")
            }
            print("\t   ", separator : "" , terminator: "")
        }
        print()
    }
}

