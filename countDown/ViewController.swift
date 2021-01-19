//
//  ViewController.swift
//  countDown
//
//  Created by Mahmut MERCAN on 12.01.2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var timer: Timer?
    var count: Int = 0
    var isTimerCounting: Bool = false
    
    var totalHour: Int!
    var totalMinutes: Int!
    var totalSeconds: Int!
    var totalTime: Int! = 0
    
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var workTimePicker: UIPickerView!
    
    override func viewDidLoad() {
        workTimePicker.delegate = self
        workTimePicker.dataSource = self
        super.viewDidLoad()
 
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workTimeSchedule.allCases[row].workTimeText
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workTimeSchedule.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        totalTime = workTimeSchedule.allCases[row].workTimeToSeconds
    }
    
    func getTimeFromInputToInt() -> Int {
        totalHour = 0
        totalMinutes = 0
        totalSeconds = 0
        
        totalTime = (totalHour + totalMinutes + totalSeconds)
        return totalTime
    }

    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        let hour = (seconds / 3600)
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 60)
        return (hour, minutes, seconds)
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
        
    @objc func timerCounter(){
        if count > 0 {
            timer?.invalidate()
//            timer = nil
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                count = count - 1
                let time = secondsToHoursMinutesSeconds(seconds: count)
                let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                currentTimeLabel.text = timeString
                if count == 0 {
                    timer?.invalidate()
                    currentTimeLabel.text = "Time is out."
                }
            }
        }
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
        if count == 0 {
            count = totalTime
        }
        if isTimerCounting == false {
            isTimerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timerCounter()
        } else {
            isTimerCounting = false
            timer?.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.timer!.invalidate()
            self.currentTimeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.systemBlue, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}



////    MARK: getTime2
//    func setupUserSchedule(restTime: Int, workTime: Int, numberRepetitions: Int) {
//
//        var restTime = restTime
//        var workTime = workTime
//        var numberRepetitions = numberRepetitions
//        if numberRepetitions > 0 {
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//                print("\(workTime) Çalışma Süresi")
//                workTime -= 1
//                if workTime == 0 {
//                    Timer.invalidate()
//                    print("Çalışma Süresi Doldu.")
//                }
//            }
//            if workTime == 0 {
//                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//                    print("\(restTime) Dinlenme Süresi")
//                    restTime -= 1
//                    if restTime == 0 {
//                        Timer.invalidate()
//                    }
//                }
//            }
//            numberRepetitions -= 1
//        } else {
//            print("Çalışma Bitmiştir.")
//        }
//    }
