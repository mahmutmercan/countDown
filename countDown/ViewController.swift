//
//  ViewController.swift
//  countDown
//
//  Created by Mahmut MERCAN on 12.01.2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var timer: Timer?
    var timerRest: Timer?
    var count: Int = 0
    var isTimerCounting: Bool = false
    var totalTime: Int! = 0
    var restTime: Int! = 5
    var workTime: Int! = 5
    var round: Int! = 1
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var workTimePicker: UIPickerView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var restTitleStackViewLabel: UILabel!
    @IBOutlet weak var roundTimeTitleStackViewLabel: UILabel!
    @IBOutlet weak var roundTitleStackViewLabel: UILabel!
    
    override func viewDidLoad() {
        workTimePicker.delegate = self
        workTimePicker.dataSource = self
        super.viewDidLoad()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return restPeriodTimeSchedule.allCases[row].restPeriodTimeText
        } else if component == 1 {
            return workTimeSchedule.allCases[row].workTimeText
        } else if component == 2 {
            return roundSchedule.allCases[row].roundTimesText
        } else {
            return workTimeSchedule.allCases[row].workTimeText
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return restPeriodTimeSchedule.allCases.count
        } else if component == 1 {
            return workTimeSchedule.allCases.count
        } else if component == 2 {
            return roundSchedule.allCases.count
        } else {
            return workTimeSchedule.allCases.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            restTime = restPeriodTimeSchedule.allCases[row].restPeriodTimeToSeconds
            print(restTime)
        } else if component == 1 {
            workTime = workTimeSchedule.allCases[row].workTimeToSeconds
            print(workTime)
        } else if component == 2 {
            round = roundSchedule.allCases[row].roundTimes
            print(round)
        } else {
            totalTime = workTimeSchedule.allCases[row].workTimeToSeconds
        }
    }
    func getTimeFromInputToInt() -> Int {
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
//    MARK: setupUserSchedule
    func setupUserSchedule() {
        if round > 0 {
            roundLabel.text = "Çalışma Zamanı"
            count -= 1
            if count == 0 {
                round -= 1
                print("Round232: \(round)")
                if round == 0 {
                    timer?.invalidate()
                    roundLabel.text = "Antrenman Bitti."
                    count = restTime
                    roundLabel.text = "Dinlenme Zamanı"
                    timer?.invalidate()
                    timerRest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                        count -= 1
                        let time = secondsToHoursMinutesSeconds(seconds: count)
                        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                        currentTimeLabel.text = timeString
                        if count == 0 {
                            timerRest?.invalidate()
                            count = workTime + 1
                            timerCounter()
                        }
                }
                }
                print("Round: \(round)")
            }
        } else if round == 0 {
            timer?.invalidate()
            roundLabel.text = "Antrenman Bitti."
        }
    }
    @objc func timerCounter(){
            timerRest?.invalidate()
            timerRest = nil
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                setupUserSchedule()
                let time = secondsToHoursMinutesSeconds(seconds: count)
                let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                currentTimeLabel.text = timeString
            }
    }
    @IBAction func startStopTapped(_ sender: Any) {
        if isTimerCounting == false {
            isTimerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            count = workTime + 1
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
