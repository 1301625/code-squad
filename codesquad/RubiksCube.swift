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
    
    
    mutating func F() {
        let tmp = cube[0][2] // 블루 색상 임시 보관
        let getW = flatColumn(1, 2) // 흰색값 가져옴
        let getR = cube[5][0] // 빨강색 가져옴
        let getG = flatColumn(3, 0) // 초록색 가져오고
        replaceHorizontalCube(changeCube: getW, cubeNumber: 0, row: 2) //블루 2 -> 흰색으로 변경
        replaceVerticalCube(changeCube: getR, cubeNumber: 1, column: 2) //흰색에서 빨강으로 변경
        replaceHorizontalCube(changeCube: getG, cubeNumber: 5, row: 0) // 빨강에서 초록으로 변경
        replaceVerticalCube(changeCube: tmp, cubeNumber: 3, column: 0) // 초록에서 파랑으로 변경
    }
    
    
    
    //MARK: 큐브 변경
    mutating func replaceVerticalCube(changeCube : [String] , cubeNumber : Int ,column : Int) {
        for i in 0...2 {
            cube[cubeNumber][i][column] = changeCube[i]
        }
    }

    mutating func replaceHorizontalCube(changeCube : [String] , cubeNumber : Int ,row : Int) {
        cube[cubeNumber][row] = changeCube
       
    }
    
    //MARK: 세로큐브 가로 변환
    func flatColumn(_ location : Int, _ column : Int) -> [String] {
        var change = [String]()
        for i in 0...2 {
            change.append(cube[location][i][column])
        }
        return change
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

