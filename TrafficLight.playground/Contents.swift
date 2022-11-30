import UIKit

class Alarm{
    var blueTimer: Timer?
    var blueCount: Int = 0
    var blueLimit: Int = 5
    
    var yellowTimer: Timer?
    var yellowCount: Int = 0
    var yellowLimit: Int = 5
    
    var redTimer: Timer?
    var redCount: Int = 0
    var redLimit: Int = 5
    
    func blueStart(){
        blueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blueLightCountup), userInfo: nil, repeats: true)
    }
    
    @objc func blueLightCountup(){
        blueCount += 1
        print("青信号のカウントは\(blueCount)です")
        if blueLimit <= blueCount {
            print("ジリリリ！（青信号のカウントをストップします）")
            blueTimer?.invalidate()
        }
    }
    
    @objc func yellowLightCountup(){
        count += 1
        print("青信号のカウントは\(count)です")
        if limit <= count {
            print("ジリリリ！（青信号のカウントをストップします）")
            timer?.invalidate()
        }
    }
    
    @objc func redLightCountup(){
        count += 1
        print("青信号のカウントは\(count)です")
        if limit <= count {
            print("ジリリリ！（青信号のカウントをストップします）")
            timer?.invalidate()
        }
    }
    
}

let alarm = Alarm()
alarm.start()
