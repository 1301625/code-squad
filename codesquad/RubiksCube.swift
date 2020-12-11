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
    var rubikCube : [[[String]]]
    
    init(){
        rubikCube = Array(repeating: Array(repeating: Array(repeating: "", count: 3), count: 3), count: 6)
        
        for i in 0...5 {
            for j in 0...2 {
                rubikCube[i][j] = Array(repeating: Color.init(num: i).rawValue, count: 3)
            }
        }
    }
    
    //MARK: 큐브 동작
    mutating func F() {
        let tmp = rubikCube[0][2] // 블루 색상 임시 보관
        replaceHorizontalCube(changeCube: flatColumn(1, 2), cubeNumber: 0, row: 2) //블루에서 흰색으로 변경
        replaceVerticalCube(changeCube: rubikCube[5][0], cubeNumber: 1, column: 2) //흰색에서 빨강으로 변경
        replaceHorizontalCube(changeCube: flatColumn(3, 0), cubeNumber: 5, row: 0) // 빨강에서 초록으로 변경
        replaceVerticalCube(changeCube: tmp, cubeNumber: 3, column: 0) // 초록에서 파랑으로 변경
    }

    mutating func Fsquoted() {
        let tmp = rubikCube[0][2] // 블루 색상 임시 보관
        replaceVerticalCube(changeCube: flatColumn(3, 0), cubeNumber: 0, column: 2) // 블루에서 초록으로 변경
        replaceHorizontalCube(changeCube: rubikCube[5][0], cubeNumber: 3, row: 0) // 초록에서 빨강으로 변경
        replaceVerticalCube(changeCube: flatColumn(1, 2), cubeNumber: 5, column: 0) // 빨강에서 흰색으로 변경
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 1, row: 2) //흰색 -> 블루으로 변경
    }

    mutating func R() {
        let tmp = flatColumn(0, 2) // 블루 색상 임시 보관
        replaceVerticalCube(changeCube: flatColumn(2, 2), cubeNumber: 0, column: 2) //블루에서 주황으로 변경
        replaceVerticalCube(changeCube: flatColumn(5, 2), cubeNumber: 2, column: 2) //주황에서 빨강으로 변경
        replaceVerticalCube(changeCube: flatColumn(4, 0), cubeNumber: 5, column: 2) // 빨강에서 노랑으로 변경
        replaceVerticalCube(changeCube: tmp, cubeNumber: 4, column: 0) // 노랑에서 파랑으로 변경
    }

    mutating func Rsquoted() {
        let tmp = flatColumn(0, 2) // 블루 색상 임시 보관
        replaceVerticalCube(changeCube: flatColumn(4, 0), cubeNumber: 0, column: 2) //블루에서 노랑으로 변경
        replaceVerticalCube(changeCube: flatColumn(5, 2), cubeNumber: 4, column: 0) //노랑에서 빨강으로 변경
        replaceVerticalCube(changeCube: flatColumn(2, 2), cubeNumber: 5, column: 2) // 빨강에서 주황으로 변경
        replaceVerticalCube(changeCube: tmp, cubeNumber: 2, column: 2) // 주황에서 파랑으로 변경
    }

    mutating func U() {
        let tmp = rubikCube[1][0] // 흰색 임시보관
        replaceHorizontalCube(changeCube: rubikCube[2][0], cubeNumber: 1, row: 0) // 흰색에서 주황
        replaceHorizontalCube(changeCube: rubikCube[3][0], cubeNumber: 2, row: 0) // 주황에서 초록
        replaceHorizontalCube(changeCube: rubikCube[4][0], cubeNumber: 3, row: 0) // 초록에서 노랑
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 4, row: 0) // 노랑에서 흰색
    }

    mutating func Usquoted() {
        let tmp = rubikCube[1][0] // 흰색 임시보관
        replaceHorizontalCube(changeCube: rubikCube[4][0], cubeNumber: 1, row: 0) // 흰색에서 노랑
        replaceHorizontalCube(changeCube: rubikCube[3][0], cubeNumber: 4, row: 0) // 노랑에서 초록
        replaceHorizontalCube(changeCube: rubikCube[2][0], cubeNumber: 3, row: 0) // 초록에서 주황
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 2, row: 0) // 주황에서 흰색
    }

    mutating func B() {
        let tmp = rubikCube[0][0]
        replaceHorizontalCube(changeCube: flatColumn(3, 2), cubeNumber: 0, row: 0) // 파랑에서 초록
        replaceVerticalCube(changeCube: rubikCube[5][2], cubeNumber: 3, column: 2) // 초록에서 빨강
        replaceHorizontalCube(changeCube: flatColumn(1, 0), cubeNumber: 5, row: 2) // 빨강에서 흰색
        replaceVerticalCube(changeCube: tmp, cubeNumber: 1, column: 0) // 흰색에서 파랑
    }

    mutating func Bsquoted() {
        let tmp = rubikCube[0][0]
        replaceHorizontalCube(changeCube: flatColumn(1, 0), cubeNumber: 0, row: 0) // 파랑에서 흰색
        replaceVerticalCube(changeCube: rubikCube[5][2], cubeNumber: 1, column: 0) // 흰색에서 빨강
        replaceHorizontalCube(changeCube: flatColumn(3, 2), cubeNumber: 5, row: 2) // 빨강에서 초록
        replaceVerticalCube(changeCube: tmp, cubeNumber: 3, column: 2) // 초록에서 파랑
    }

    mutating func L() {
        let tmp = flatColumn(0, 0)
        replaceVerticalCube(changeCube: flatColumn(4, 2), cubeNumber: 0, column: 0) // 파랑에서 노랑
        replaceVerticalCube(changeCube: flatColumn(5, 0), cubeNumber: 4, column: 2) // 노랑에서 빨강
        replaceVerticalCube(changeCube: flatColumn(2, 0), cubeNumber: 5, column: 0) // 빨강에서 주황
        replaceVerticalCube(changeCube: tmp, cubeNumber: 2, column: 0) // 주황에서 파랑
    }

    mutating func Lsquoted() {
        let tmp = flatColumn(0, 0)
        replaceVerticalCube(changeCube: flatColumn(2, 0), cubeNumber: 0, column: 0) // 파랑에서 주황
        replaceVerticalCube(changeCube: flatColumn(5, 0), cubeNumber: 2, column: 0) // 주황에서 삘강
        replaceVerticalCube(changeCube: flatColumn(4, 2), cubeNumber: 5, column: 0) // 빨강에서 노랑
        replaceVerticalCube(changeCube: tmp, cubeNumber: 4, column: 2) // 노랑에서 파랑
    }

    mutating func D() {
        let tmp = rubikCube[1][2] // 흰색 임시보관
        replaceHorizontalCube(changeCube: rubikCube[4][2], cubeNumber: 1, row: 2) // 흰색에서 노랑
        replaceHorizontalCube(changeCube: rubikCube[3][2], cubeNumber: 4, row: 2) // 노랑에서 초록
        replaceHorizontalCube(changeCube: rubikCube[2][2], cubeNumber: 3, row: 2) // 초록에서 주황
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 2, row: 2) // 주황에서 흰색
    }

    mutating func Dsquoted() {
        let tmp = rubikCube[1][2]
        replaceHorizontalCube(changeCube: rubikCube[2][2], cubeNumber: 1, row: 2) // 흰색에서 주황
        replaceHorizontalCube(changeCube: rubikCube[3][2], cubeNumber: 2, row: 2) // 주황에서 초록
        replaceHorizontalCube(changeCube: rubikCube[4][2], cubeNumber: 3, row: 2) // 초록에서 노랑
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 4, row: 2) // 노랑에서 흰색
    }
    
    
    //MARK: 큐브 회전(시계방향, 반시계방향)
    mutating func rotationRight(cubeNumber : Int) {
        var tmp = Array(repeating: Array(repeating: "", count: 3), count: 3)
        for i in 0...2 {
            tmp[i] = rubikCube[cubeNumber][i]
        }
        var j = 0
        for i in stride(from: 2, through: 0, by: -1) {
            replaceCube(temp: tmp[j], location: cubeNumber, column: i)
            j += 1
        }
    }
    mutating func rotationLeft(cubeNumber : Int) {
        var tmp = Array(repeating: Array(repeating: "", count: 3), count: 3)
        for i in 0...2 {
            tmp[i] = rubikCube[cubeNumber][i]
        }
        
        for i in 0...2 {
            replaceCube(temp: tmp[i].reversed(), location: cubeNumber, column: i)
        }
    }
    
    //MARK: 큐브 변경
    mutating func replaceCube(temp : [String] ,location : Int,  column : Int) {
        for i in 0...2 {
            rubikCube[location][i][column] = temp[i]
        }
    }
    
    
    //MARK: 큐브 변경
    mutating func replaceVerticalCube(changeCube : [String] , cubeNumber : Int ,column : Int) {
        for i in 0...2 {
            rubikCube[cubeNumber][i][column] = changeCube[i]
        }
    }

    mutating func replaceHorizontalCube(changeCube : [String] , cubeNumber : Int ,row : Int) {
        rubikCube[cubeNumber][row] = changeCube
       
    }
    
    //MARK: 세로큐브 가로 변환
    func flatColumn(_ location : Int, _ column : Int) -> [String] {
        var change = [String]()
        for i in 0...2 {
            change.append(rubikCube[location][i][column])
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
                print(rubikCube[side][j][k], separator: "" , terminator: " ")
            }
            print()
        }
        print()
    }
    
    func middleCubePrint(floor : Int) {
        for i in 1...4 {
            for k in 0...2 {
                print(rubikCube[i][floor][k], separator : "" , terminator: " ")
            }
            print("\t   ", separator : "" , terminator: "")
        }
        print()
    }
}

