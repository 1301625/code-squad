## 2단계: 평면 큐브 구현하기

###  구조

1. 메인.swift 에서 `Cube` 생성 후 , 초기 상태 출력
2. 반복적으로 큐브를 돌리기 위해 while문으로 입력값을 받고 Q 입력시 종료
3. 입력 받은 동작들은 배열로 변경후 `cube.process()`함수 호출 후 입력한 순서로 동작 출력 후 평면 큐브 변경 
4. 변경된 큐브 출력 후 다시 동작 입력 반복

### 코드

- 동작 입력

```swift
enum Action : String {
    case U, R, L, B
    case Usquoted = "U'"
    case Rsquotud = "R'"
    case Lsquoted = "L'"
    case Bsquoted = "B'"
}

while true {
    
    print("CUBE> ", separator: "", terminator: "")
    let input = readLine() ?? ""
    
    if input == "Q" || input == "q" {
        print("Bye~")
        break
    }
    cubeAction(input : input)
}

func cubeAction(input : String) {
    let actionText = inputConvert(input : input.map { String($0) })
    cube.process(input: actionText)
}

func inputConvert(input : [String]) -> [Action] {
    var tempArr = [String]()
    for i in 0..<input.count {
        if input[i] == "'" {
            tempArr[tempArr.count-1] += "'"
        } else {
            tempArr.append(input[i])
        }
    }
    return tempArr.compactMap { Action(rawValue: $0) }
}

```

swift `readLine()` 은 옵셔널 값이기에 nil 병합 연산자 사용하여 작성했다

`cubeAction(input : input)`  사용자가 입력한 동작을 가공하고  `cube.process(input : actionText)` 호출하여 입력한 순서로 동작

`inputConvert(input : input.map { String($0) })` 입력한 값을 가공하는 함수로써 매개변수로 input 값을 [String]으로 변환후 전달

`UU'R 입력시  -> input = UU'R `

` input.map { String($0) } -> ["U", "U", "'" , "R"] `  

`inputConvert()` 함수 호출시  tempArr 배열을 생성 후  `'` 나올시 이전 배열에 `'` 추가하고 아닐시 매개변수로 들어온 값을 추가 한다

tempArr를 열거형 배열로 반환하기 위해 compactMap 사용(nil 제거 및 옵셔널 바인딩) 하여 `actionText` 변수에 저장

`actionText = ["U" ,"Usquoted", "R"]` 

- 동작 프로세스

```swift
mutating func process(input : [Action]) {
        print()
        input.forEach { (action) in
						print(action.toString())
            switch action {
            case .U:
                cube[0] = leftPush(cube: cube[0])
            case .R:
                upDownPush(column : 2, action: .R)
						.....
         		case .Usquoted:
                cube[0] = rightPush(cube: cube[0])
            case .Rsquotud:
                upDownPush(column: 2, action: .Rsquotud)
            ....
            }
            cubePrint()
        }
    }
  
enum Action : String {
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
```

`process()`  받아온 [Action] 을 순서대로 꺼내며 switch-case  값 비교,해당 동작문자 출력 및 큐브 밀기, 큐브 배열 출력

forEach를 돌면서 동작문자가 `U,R,L,Bsquoted`  출력 되는것을 `U',R',L',B'`  출력하기 위해 `enum에 있는 toString()` 함수에서 지정한 값으로 반환 후 출력

- 큐브 밀기

```swift
 mutating func leftPush(cube piece : [String]) -> [String] {
        let index = 1
        return Array(piece[index..<piece.count] + piece[0..<index])
    }
    
    mutating func rightPush(cube piece : [String]) -> [String] {
        let index = 2
        return Array(piece[index..<piece.count] + piece[0..<index])
    }
    
    mutating func upDownPush(column : Int, action : Action){
        var cubeArray = flatColumn(column)
        cubeArray = action == .R || action == .Lsquoted ?
            leftPush(cube: cubeArray) : rightPush(cube: cubeArray)
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
```

`leftPush(), rightPush()` 매개변수로 움직일 1차원 배열을 받고 좌우 밀기

`upDownPush()`  움직일 column 과 동작을 매개변수로 받아   `flatColum()` 함수로 움직일 column을 1차원배열로 만들어 변수(`cubeArray`)로 저장 

동작의 값에 따라 `cubeArray`  를   `leftPush()`  or  `rightPush()`  민 후  `replaceCube()` 통해  해당 column에 밀어낸 큐브 배열을 삽입한다

 
