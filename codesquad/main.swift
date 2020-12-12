//
//  main.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/07.
//

import Foundation


while true {
    print("1단계: 단어 밀어내기")
    let input = readLine()!.components(separatedBy: " ")
    var pushword = PushWord(word: input[0],
                            count: Int(input[1]) ?? 0 ,
                            control: Control(rawValue: input[2]))
    pushword.process()
    print()
}
