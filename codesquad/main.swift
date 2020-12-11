//
//  main.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/07.
//

import Foundation

var cube = RubiksCube()
cube.cubePrint()

var actionCount = 0

while true {
    
    print("CUBE> ", separator: "", terminator: "")
    let input = readLine() ?? ""
    
    if input == "Q" || input == "q" {
        print("조각갯수: \(actionCount)")
        print("이용해주셔서 감사합니다")
        break
    }
    cubeAction(input : input)
}

func cubeAction(input : String) {
    let actionText = inputConvert(input : input.map { String($0) })
    actionCount = actionText.count
    cube.process(input: actionText)
}

func inputConvert(input : [String]) -> [Action] {
    var tempArr = [String]()
    for i in 0..<input.count {
        if input[i] == "'" {
            tempArr[tempArr.count-1] += "'"
        } else if input[i] == "2" {
            tempArr.append(input[i+1])
        } else {
            tempArr.append(input[i])
        }
    }
    return tempArr.compactMap { Action(rawValue: $0) }
}


//cube.cubePrint()
