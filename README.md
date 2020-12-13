## 3단계: 루빅스 큐브 구현하기

###  구조

1. 시작시 현재 절대 시간 선언 및 초기화 
2. 메인.swift 에서 `Cube` 생성 후 , 초기 상태 출력 , 동작갯수 카운터 초기화 
3. 반복적으로 큐브를 돌리기 위해 while문으로 입력값을 받고 Q 입력시 종료 ,   S 입력시 무작위 섞기 기능
4. 입력 받은 동작들은 배열로 변경후 `cube.process()`함수 호출 후 입력한 순서로 동작 출력 후 루빅스 큐브 변경 
5. 변경된 큐브 출력 후 다시 동작 입력 반복,  모든 큐브를 맞출시 축하메세지와 함께  프로그램 종료
6. Q 입력 종료시 경과시간, 입력한 동작 갯수 출력

###  코드

- 큐브 생성

````swift
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
````

큐브의 색을 열거형 만들고 순서를 지정하여 큐브를 배열을 추가

모든 면과 같은지 검사 하기 위한 `completeCube` 변수를 생성 큐브(`rubikCube`)값으로 저장

- 입력 

```swift
enum Action : String {
    case U, L, F, R, B, D
    case Usquoted = "U'"
    case Lsquoted = "L'"
    case Fsquoted = "F'"
    case Rsquoted = "R'"
    case Bsquoted = "B'"
    case Dsquoted = "D'"
}

while true {
    print("CUBE> ", separator: "", terminator: "")
    let input = readLine() ?? ""
        
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
            tempArr.append(input[i+1])
        } else {
            tempArr.append(input[i])
        }
    }
    return tempArr.compactMap { Action(rawValue: $0) }
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
```

while true 로 반복적으로 큐브를 입력 받게 하였다

swift `readLine()` 은 옵셔널 값이기에 nil 병합 연산자 사용하여 작성했다

`cubeAction(input : input)`  사용자가 입력한 동작을 가공하고  `cube.process(input : actionText)` 호출하여 입력한 순서로 동작

`inputConvert(input : input.map { String($0) })`은 입력한 값을 가공하는 함수로써 매개변수로 input 값을 [String]으로 변환후 전달

`UU'R 입력시  -> input = UU'R `

` input.map { String($0) } -> ["U", "U", "'" , "R"] `  

`inputConvert()` 함수 호출시  tempArr 배열을 생성 후  `'` 나올시 이전 배열에 `'` 추가하고 아닐시 매개변수로 들어온 값을 추가 한다



2가 들어온 경우 매개변수 뒤에 동작문자가 있기 때문에 input[i+1] 하여 그 다음문자를 tempArr에 추가한다 



tempArr를 열거형 배열로 반환하기 위해 compactMap 사용(nil 제거 및 옵셔널 바인딩) 하여 `actionText` 변수에 저장

`actionText = ["U" ,"Usquoted", "R"]` 

`S or s` 입력하면 셔플 기능으로  `cubeShuffle()`가 호출된다 동작배열을 가진 action 변수를 `Int.random(in : 0...11)` 를 활용해 0~11의 숫자를 랜덤으로 동작의 번호를 뽑아 배열에 저장후 동작배열을 반환 한 후 `cube.process()`를 통해 큐브를 동작해 임의로 섞이게 한다 

- 동작

```swift
enum Action : String {
	  func toString() -> String {
        switch self {
        case .Usquoted : return "U'"
        case .Lsquoted : return "L'"
        case .Fsquoted : return "F'"
        case .Rsquoted : return "R'"
        case .Bsquoted : return "B'"
        case .Dsquoted : return "D'"
        default:
            return self.rawValue
        }
    }
}
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
						......
            case .Usquoted:
                Usquoted()
            case .Lsquoted:
                Lsquoted()
     				.....
            }
            cubePrint()
        }
    }
    
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
		......

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
    
    mutating func replaceCube(temp : [String] ,location : Int,  column : Int) {
        for i in 0...2 {
            rubikCube[location][i][column] = temp[i]
        }
    }
    
    mutating func replaceVerticalCube(changeCube : [String] , cubeNumber : Int ,column : Int) {
        for i in 0...2 {
            rubikCube[cubeNumber][i][column] = changeCube[i]
        }
    }

    mutating func replaceHorizontalCube(changeCube : [String] , cubeNumber : Int ,row : Int) {
        rubikCube[cubeNumber][row] = changeCube
       
    }
    
    func flatColumn(_ location : Int, _ column : Int) -> [String] {
        var change = [String]()
        for i in 0...2 {
            change.append(rubikCube[location][i][column])
        }
        return change
    }
```

`process` 함수는 매개변수로 들어온 [action] 값에 따라 차례대로 진행 , 큐브상태 출력

`action.toString()` 으로  action 값이 squoted 붙여 나오는것을 `' `  으로 나오도록 변경



알파벳만 있는경우 시계방향으로 회전,  `'` 가 있는경우 반시계 방향으로 회전 하므로 각 동작 마다 회전을 추가 하였음

`rotationLeft`  - 움직일 큐브 면을 임시배열에 저장 , 저장한 임시배열을 반대로 바꿔  `replaceCube`함수에 매개변수로 넣어 전달 차례대로 현재 큐브면에 세로값에 변경 

`rotationRight` - 움직일 큐브 면을 임시배열에 저장, 저장한 임시배열을 차례대로 진행되어야하고 반복은 반대로 큐브의 오른쪽부터 진행 되어야 했다


큐브기호동작  12가지 -  tmp 임시로 움직이는 큐브 한 위치를 저장한 후 

기호 동작에 맞게 `replaceHorizontalCube` ,  `replaceVerticalCube` 를 사용하여 위치를 이동 시킨다

`replaceHorizontalCube` 경우 함수 이름과 같이 배열을 가로로 변경해야하므로  변경할 배열과 ,변경할 큐브 면, 변경위치를 받는다

 `replaceVerticalCube`  배열을 세로로 변경하므로 포문을 이용하여 변경할 배열 위치 값을 변경

`flatColumn()` 변경하고자 하는 세로 배열위치를 1차원 배열로 만들어 반환한다



- 출력

````swift
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
````

`cubePrint()`  큐브 전체 모습을 출력

`sideCubePrint()`  초기 상태의 B,R 양 옆을 출력하는 함수

`middleCubePrint()`  중간을 출력하는 함수 큐브 한 줄 씩 출력하여 보여지도록 했다 W W W  O O O  G G G  Y Y Y

- 종료

```swift
let startTime = CFAbsoluteTimeGetCurrent()
var actionCount = 0

while true {
   	....
    if input == "Q" || input == "q" {
        cubeEnd()
        break
    }
    
		.....
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

func totalTime(time : Int) {
    let min : String = { time / 60 < 10 ? "0\(time / 60)" : "\(time / 60)" }()
    let second : String = { time % 60 < 10 ? "0\(time % 60)" : "\(time % 60)" }()
    print("경과시간: \(min):\(second)" )
}

func cubeEnd() {
    let endTime = CFAbsoluteTimeGetCurrent() - startTime
    totalTime(time: Int(endTime))
    print("조각갯수: \(actionCount)")
    print("이용해주셔서 감사합니다. 뚜뚜뚜.")
}


//RubiksCube.swift
func completeCubeCheck() -> Bool {
        return completeCube == rubikCube
}
```

`Q 입력` -  `cubeEnd()` 호출  `CFAbsoluteTimeGetCurrent()` 현재 시간을 가져온 후 시작시 저장 된 startTime 뺀 값을

Int 변경하여 `totalTime(time : Int)` 에 매개변수로 넣어 전달한다 

시간은  time / 60 , time % 60으로 분과 초를 구하고 그 값이 10보다 작으면  0을 붙여 저장



조각갯수 - `cube.process()` 에 들어갈 actionText의 배열값의 갯수를 actionCount에 저장 후 종료 시 출력



모든 면 맞출시 종료 -  `cubeAction()` 사용자가 입력한 큐브 동작이 모두 끝난후  completeCubeCheck 함수를 호출 하여 현재 큐브와 완성된 큐브과 같은지 검증하고 같다면 축하메세지와 함께 main while문을 종료 시켜 프로그램이 종료하게 된다

