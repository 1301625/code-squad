//
//  main.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/07.
//

import Foundation

let startTime = CFAbsoluteTimeGetCurrent()

var cube = RubiksCube()
cube.cubePrint()

var actionCount = 0

print(" - 큐브섞기 'CUBE> S'")

while true {
    print("CUBE> ", separator: "", terminator: "")
    let input = readLine() ?? ""   // 입력값 F R R' U2 R
        
    if input == "Q" || input == "q" {
        cubeEnd()
        break
    }
    
    else if input == "S" || input == "s" {
        cube.process(input: cubeShuffle())
    }
    
    cubeAction(input : input)
    
    if cube.completeCubeCheck() {
        print("모든면을 맞추셨습니다 축하합니다")
        break
    }
}

func cubeAction(input : String) {
    let actionText = inputConvert(input : input.map { String($0) })
    actionCount += actionText.count
    cube.process(input: actionText)
}

func inputConvert(input : [String]) -> [Action] {
    var tempArr = [String]()
    for i in 0..<input.count {
        if input[i] == "'" {
            tempArr[tempArr.count-1] += "'"
        } else if input[i] == "2" {
            tempArr.append(input[i-1])
        } else {
            tempArr.append(input[i])
        }
    }
    return tempArr.compactMap { Action(rawValue: $0) }
}

func totalTime(time : Int) {
    let min : String = { time / 60 < 10 ? "0\(time / 60)" : "\(time / 60)" }()
    let second : String = { time % 60 < 10 ? "0\(time % 60)" : "\(time % 60)" }()
    print("경과시간: \(min):\(second)" )
}



func cubeShuffle() -> [Action] {
    let action : [Action] = [.F, .Fsquoted, .R, .Rsquoted, .U, .Usquoted,
                             .B, .Bsquoted, .L, .Lsquoted, .D, .Dsquoted]
    var shuffleAction : [Action] = []
    for _ in 0...8 {
        shuffleAction.append(action[Int.random(in: 0...11)])
    }
    return shuffleAction
}

func cubeEnd() {
    let endTime = CFAbsoluteTimeGetCurrent() - startTime
    totalTime(time: Int(endTime))
    print("조각갯수: \(actionCount)")
    print("이용해주셔서 감사합니다. 뚜뚜뚜.")
}
