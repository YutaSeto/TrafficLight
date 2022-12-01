import UIKit

//青→黄→赤→青→黄→赤→・・・と循環する形で信号が切り替わる
//各色でのタイマーを作成
//光っている時間を決める変数
//赤信号に切り替わってから数秒後に他の信号を切り替える
//赤信号の時間の定義ー対の信号の青信号と黄色信号と赤信号に切り替わってからの数秒の合計の時間


class TrafficLight{
    var blueTimer: Timer?
    var blueCount: Int = 0 //秒
    var blueLimit: Int = 5 //秒
    
    var yellowTimer: Timer?
    var yellowCount: Int = 0 //秒
    var yellowLimit: Int = 3 //秒
    
    var changeTimer: Timer?
    var changeCount: Int = 0 //秒
    var changeBlueLight: Int = 2 //秒
    
    var anotherBlueLimit = 10 //秒
    var anotherYellowLimit = 3 //秒
    
    var redTimer: Timer?
    var redCount: Int = 0 //秒
    var redLimit: Int{
        return anotherBlueLimit + anotherYellowLimit + changeBlueLight // \(changeBlueLight)以上の整数
    }
    
    func blueStart(){
        blueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blueLightCountup), userInfo: nil, repeats: true)
        print("(青信号を光らせる)")
    }
    
    func yellowStart(){
        yellowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(yellowLightCountup), userInfo: nil, repeats: true)
        print("(黄色信号を光らせる)")
    }
    
    func redStart(){
        redTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(redLightCountup), userInfo: nil, repeats: true)
        print("(赤信号を光らせる)")
    }
    
    func changeLight(){
        changeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeLightCountUp), userInfo: nil, repeats: true)
        print("(他の信号を青信号に切り替える)")
    }
    
    @objc func blueLightCountup(){
        blueCount += 1
        print("青信号はあと\(blueLimit - blueCount)秒")
        if blueLimit <= blueCount {
            print("(青信号の光を止める)")
            blueTimer?.invalidate()
            blueCount = 0
            yellowStart()
        }
    }
    
    @objc func yellowLightCountup(){
        yellowCount += 1
        print("黄信号はあと\(yellowLimit - yellowCount)秒")
        if yellowLimit < yellowCount {
            print("(黄信号の光を止める)")
            yellowTimer?.invalidate()
            yellowCount = 0
            redStart()
            changeLight()
        }
    }
    
    @objc func changeLightCountUp(){
        changeCount += 1
    print("あと\(changeBlueLight - changeCount)秒で他の信号が青に切り替わる")
        if changeBlueLight - changeCount <= 0{
            print("(他の信号が青に切り替わる)")
            changeTimer?.invalidate()
            changeCount = 0
        }
    }
    
    @objc func redLightCountup(){
        redCount += 1
        print("赤信号は残り\(redLimit - redCount)秒")
        if redLimit <= redCount {
            print("(赤信号の光を止める)")
            redTimer?.invalidate()
            redCount = 0
            blueStart()
        }
    }
    
}

let trafficLight = TrafficLight()
trafficLight.blueStart()
