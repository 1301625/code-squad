//
//  RubikCube.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/10.
//

import Foundation


struct RubiksCube {
    var rubikCube : [[[String]]]
    let completeCube : [[[String]]]
    
    //MARK: 큐브생성
    init(){
        rubikCube = Array(repeating: Array(repeating: Array(repeating: "", count: 3), count: 3), count: 6)
        
        for i in 0...5 {
            for j in 0...2 {
                rubikCube[i][j] = Array(repeating: Color.init(num: i).rawValue, count: 3)
            }
        }
        completeCube = rubikCube
    }
    
    
    //MARK: 실행
    mutating func process(input : [Action]) {
        print()
        input.forEach { (action) in
            print(action.toString())
            switch action {
            case .U:
                U()
            case .L:
                L()
            case .F:
                F()
            case .R:
                R()
            case .B:
                B()
            case .D:
                D()
            case .Usquoted:
                Usquoted()
            case .Lsquoted:
                Lsquoted()
            case .Fsquoted:
                Fsquoted()
            case .Rsquoted:
                Rsquoted()
            case .Bsquoted:
                Bsquoted()
            case .Dsquoted:
                Dsquoted()
            }
            cubePrint()
        }
    }
    
    //MARK: 큐브 동작
    mutating func F() {
        rotationRight(cubeNumber: 2)
        let tmp = rubikCube[0][2]
        replaceHorizontalCube(changeCube: flatColumn(1, 2).reversed(), cubeNumber: 0, row: 2)
        replaceVerticalCube(changeCube: rubikCube[5][0], cubeNumber: 1, column: 2)
        replaceHorizontalCube(changeCube: flatColumn(3, 0).reversed(), cubeNumber: 5, row: 0)
        replaceVerticalCube(changeCube: tmp, cubeNumber: 3, column: 0)
    }

    mutating func Fsquoted() {
        rotationLeft(cubeNumber: 2)
        let tmp = rubikCube[0][2]
        replaceHorizontalCube(changeCube: flatColumn(3, 0), cubeNumber: 0, row: 2)
        replaceVerticalCube(changeCube: rubikCube[5][0].reversed(), cubeNumber: 3, column: 0)
        replaceHorizontalCube(changeCube: flatColumn(1, 2), cubeNumber: 5, row: 0)
        replaceVerticalCube(changeCube: tmp.reversed(), cubeNumber: 1, column: 2)
    }

    mutating func R() {
        rotationRight(cubeNumber: 3)
        let tmp = flatColumn(0, 2)
        replaceVerticalCube(changeCube: flatColumn(2, 2), cubeNumber: 0, column: 2)
        replaceVerticalCube(changeCube: flatColumn(5, 2), cubeNumber: 2, column: 2)
        replaceVerticalCube(changeCube: flatColumn(4, 0).reversed(), cubeNumber: 5, column: 2)
        replaceVerticalCube(changeCube: tmp.reversed(), cubeNumber: 4, column: 0)
    }

    mutating func Rsquoted() {
        rotationLeft(cubeNumber: 3)
        let tmp = flatColumn(0, 2)
        replaceVerticalCube(changeCube: flatColumn(4, 0).reversed(), cubeNumber: 0, column: 2)
        replaceVerticalCube(changeCube: flatColumn(5, 2).reversed(), cubeNumber: 4, column: 0)
        replaceVerticalCube(changeCube: flatColumn(2, 2), cubeNumber: 5, column: 2)
        replaceVerticalCube(changeCube: tmp, cubeNumber: 2, column: 2)
    }

    mutating func U() {
        rotationRight(cubeNumber: 0)
        let tmp = rubikCube[1][0]
        replaceHorizontalCube(changeCube: rubikCube[2][0], cubeNumber: 1, row: 0)
        replaceHorizontalCube(changeCube: rubikCube[3][0], cubeNumber: 2, row: 0)
        replaceHorizontalCube(changeCube: rubikCube[4][0], cubeNumber: 3, row: 0)
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 4, row: 0)
    }

    mutating func Usquoted() {
        rotationLeft(cubeNumber: 0)
        let tmp = rubikCube[1][0]
        replaceHorizontalCube(changeCube: rubikCube[4][0], cubeNumber: 1, row: 0)
        replaceHorizontalCube(changeCube: rubikCube[3][0], cubeNumber: 4, row: 0)
        replaceHorizontalCube(changeCube: rubikCube[2][0], cubeNumber: 3, row: 0)
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 2, row: 0)
    }

    mutating func B() {
        rotationRight(cubeNumber: 4)
        let tmp = rubikCube[0][0]
        replaceHorizontalCube(changeCube: flatColumn(3, 2), cubeNumber: 0, row: 0)
        replaceVerticalCube(changeCube: rubikCube[5][2].reversed(), cubeNumber: 3, column: 2)
        replaceHorizontalCube(changeCube: flatColumn(1, 0), cubeNumber: 5, row: 2)
        replaceVerticalCube(changeCube: tmp.reversed(), cubeNumber: 1, column: 0)
    }

    mutating func Bsquoted() {
        rotationLeft(cubeNumber: 4)
        let tmp = rubikCube[0][0]
        replaceHorizontalCube(changeCube: flatColumn(1, 0).reversed(), cubeNumber: 0, row: 0)
        replaceVerticalCube(changeCube: rubikCube[5][2], cubeNumber: 1, column: 0)
        replaceHorizontalCube(changeCube: flatColumn(3, 2).reversed(), cubeNumber: 5, row: 2)
        replaceVerticalCube(changeCube: tmp, cubeNumber: 3, column: 2)
    }

    mutating func L() {
        rotationRight(cubeNumber: 1)
        let tmp = flatColumn(0, 0)
        replaceVerticalCube(changeCube: flatColumn(4, 2).reversed(), cubeNumber: 0, column: 0)
        replaceVerticalCube(changeCube: flatColumn(5, 0).reversed(), cubeNumber: 4, column: 2)
        replaceVerticalCube(changeCube: flatColumn(2, 0), cubeNumber: 5, column: 0)
        replaceVerticalCube(changeCube: tmp, cubeNumber: 2, column: 0)
    }

    mutating func Lsquoted() {
        rotationLeft(cubeNumber: 1)
        let tmp = flatColumn(0, 0)
        replaceVerticalCube(changeCube: flatColumn(2, 0), cubeNumber: 0, column: 0)
        replaceVerticalCube(changeCube: flatColumn(5, 0), cubeNumber: 2, column: 0)
        replaceVerticalCube(changeCube: flatColumn(4, 2).reversed(), cubeNumber: 5, column: 0)
        replaceVerticalCube(changeCube: tmp.reversed(), cubeNumber: 4, column: 2)
    }

    mutating func D() {
        rotationRight(cubeNumber: 5)
        let tmp = rubikCube[1][2]
        replaceHorizontalCube(changeCube: rubikCube[4][2], cubeNumber: 1, row: 2)
        replaceHorizontalCube(changeCube: rubikCube[3][2], cubeNumber: 4, row: 2)
        replaceHorizontalCube(changeCube: rubikCube[2][2], cubeNumber: 3, row: 2)
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 2, row: 2)
    }

    mutating func Dsquoted() {
        rotationLeft(cubeNumber: 5)
        let tmp = rubikCube[1][2]
        replaceHorizontalCube(changeCube: rubikCube[2][2], cubeNumber: 1, row: 2)
        replaceHorizontalCube(changeCube: rubikCube[3][2], cubeNumber: 2, row: 2)
        replaceHorizontalCube(changeCube: rubikCube[4][2], cubeNumber: 3, row: 2)
        replaceHorizontalCube(changeCube: tmp, cubeNumber: 4, row: 2)
    }

    
    //MARK: 큐브 회전 (시계방향)
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
    
    //MARK: 큐브 회전 (반시계방향)
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
    
    //MARK: 큐브완성 비교
    func completeCubeCheck() -> Bool {
        return completeCube == rubikCube
    }
}

