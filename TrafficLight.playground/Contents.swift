import UIKit

class Alarm{
    var blueTimer: Timer?
    var blueCount: Int = 0
    var blueLimit: Int = 10
    
    var yellowTimer: Timer?
    var yellowCount: Int = 0
    var yellowLimit: Int = 3
    
    var redTimer: Timer?
    var redCount: Int = 0
    var redLimit: Int = 5
    
    func blueStart(){
        blueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blueLightCountup), userInfo: nil, repeats: true)
    }
    
    func yellowStart(){
        yellowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(yellowLightCountup), userInfo: nil, repeats: true)
    }
    
    func redStart(){
        redTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(redLightCountup), userInfo: nil, repeats: true)
    }
    
    @objc func blueLightCountup(){
        blueCount += 1
        print("青信号のカウントは\(blueCount)です")
        if blueLimit <= blueCount {
            print("（青信号の光を止める）")
            blueTimer?.invalidate()
            blueCount = 0
            yellowStart()
            print("黄色信号を光らせる")
        }
    }
    
    @objc func yellowLightCountup(){
        yellowCount += 1
        print("黄信号のカウントは\(yellowCount)です")
        if yellowLimit <= yellowCount {
            print("（黄信号の光を止める）")
            yellowTimer?.invalidate()
            yellowCount = 0
            redStart()
            print("赤信号を光らせる")
        }
    }
    
    @objc func redLightCountup(){
        redCount += 1
        print("赤信号のカウントは\(redCount)です")
        if redLimit <= redCount {
            print("（赤信号の光を止める）")
            redTimer?.invalidate()
            redCount = 0
            blueStart()
            print("青信号を光らせる")
        }
    }
    
}

let alarm = Alarm()
alarm.blueStart()
