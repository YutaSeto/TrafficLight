import UIKit

class Alarm{
    var timer: Timer?
    var count: Int = 0
    var limit: Int = 5
    

    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blueLightCountup), userInfo: nil, repeats: true)
    }
    
    @objc func blueLightCountup(){
        count += 1
        print("青信号のカウントは\(count)です")
        if limit <= count {
            print("ジリリリ！（青信号のカウントをストップします）")
            timer?.invalidate()
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
