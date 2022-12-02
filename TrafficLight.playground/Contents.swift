import UIKit

//青→黄→赤→青→黄→赤→・・・と循環する形で信号が切り替わる
//各色でのタイマーを作成
//光っている時間を決める変数
//赤信号に切り替わってから数秒後に他の信号を切り替える
//赤信号の時間の定義ー対の信号の青信号と黄色信号と赤信号に切り替わってからの数秒の合計の時間
//対の信号の青と黄色と切り替わるまでの数秒を定義して赤信号から青信号に切り替わる時間の定義

//例外ケース
//時間によって感応式に切り替わる

//現在時刻の取得
var nowDate = Date()
private var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    dateFormatter.locale = Locale(identifier:"ja-JP")
    return dateFormatter
}

class TrafficLight{
    var blueTimer: Timer?
    var blueCount: Int = 0 //秒
    let blueLimit: Int = 5 //秒
    
    var yellowTimer: Timer?
    var yellowCount: Int = 0 //秒
    let yellowLimit: Int = 3 //秒
    
    var changeTimer: Timer?
    var changeCount: Int = 0 //秒
    let changeBlueLight: Int = 2 //秒
    
    var anotherBlueLimit = 10 //秒
    let anotherYellowLimit = 3 //秒
    
    var redTimer: Timer?
    var redCount: Int = 0 //秒
    var redLimit: Int{
        return anotherBlueLimit + anotherYellowLimit + changeBlueLight // \(changeBlueLight)以上の整数
    }
    
    var isCarSencer: Bool = false
    
    var isPushButton: Bool = false
    
    
    var timer: Timer?
    
    func timeStart(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCountup), userInfo: nil, repeats: true)
    }
    
    @objc func timeCountup(){
        nowDate += 1
        print("現在の時刻は\(dateFormatter.string(from: nowDate))です")
    }
    
    
    func blueStart(){
        blueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(blueLightCountup), userInfo: nil, repeats: true)
        print("(青信号を光らせる)")
    }
    
    func nightBlueStart(){
        print("(青信号を光らせる)")
        if isCarSencer{
            blueCount += 1
            print("青信号はあと\(blueLimit - blueCount)秒")
            if blueLimit <= blueCount {
                print("(青信号の光を止める)")
                blueTimer?.invalidate()
                blueCount = 0
                yellowStart()
            }
        }
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
            isCarSencer = false
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
        //夜間だけ押しボタンが押せるフラグを立てる
        let hour = Calendar.current.component(.hour, from:nowDate)
        if hour >= 22 || hour <= 3 && isPushButton == false{
            print("押しボタンの表示を「押してください」を表示")
        }
        if redLimit - redCount < 10{
            print("押しボタンの表示を「お待ちください」に変更")
        }
        
        redCount += 1
        print("赤信号は残り\(redLimit - redCount)秒")
        
        if redLimit <= redCount {
            if hour >= 22 || hour <= 3{
                print("赤信号の光を止める")
                redTimer?.invalidate()
                redCount = 0
                isPushButton = false
                nightBlueStart()
            }else{
                print("(赤信号の光を止める)")
                redTimer?.invalidate()
                redCount = 0
                isPushButton = false
                blueStart()
            }
        }
    }
    
    func carSencer(){
        return isCarSencer = true
    }
    
    func pushButton(){
        print("押しボタンの表示を「お待ちください」に変更")
        if redCount != 0 && isPushButton == false && redCount <= redLimit - 10 {
            isPushButton = true
            return redCount = redLimit - 10
        }
    }
    
}

let trafficLight = TrafficLight()
trafficLight.blueStart()
trafficLight.timeStart()

