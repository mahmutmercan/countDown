//
//  ViewController.swift
//  countDown
//
//  Created by Mahmut MERCAN on 12.01.2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var timer: Timer?
    var roundCount: Int = 1
    var timerRest: Timer?
    var count: Int = 0
    var isTimerCounting: Bool = false
    var totalTime: Int! = 0
    var restTime: Int! = 180
    var workTime: Int! = 600
    var round: Int! = 10
    var gradient: CAGradientLayer?
    
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
    @IBOutlet weak var roundTimeLabel: UILabel!
    
    override func viewDidLoad() {
        workTimePicker.delegate = self
        workTimePicker.dataSource = self
        setupView()
        setupGradient()
        super.viewDidLoad()
    }
    
    func setupView() {
        currentTimeLabel.textColor = .white
        roundLabel.textColor = .white
        roundTimeLabel.textColor = .white
        workTimePicker.selectRow(5, inComponent: 0, animated: true)
        workTimePicker.selectRow(4, inComponent: 1, animated: true)
        workTimePicker.selectRow(5, inComponent: 2, animated: true)
        startStopButton.layer.cornerRadius = 12
        restartButton.layer.cornerRadius = 12
    }
    
    private func setupGradient(){
        gradient?.removeFromSuperlayer()
        
        var gradientStartColor = UIColor(red: 0/255.0, green: 242/255.0, blue: 96/255.0, alpha: 1.0).cgColor
        var gradientMidColor = UIColor(red: 0/255.0, green: 242/255.0, blue: 96/255.0, alpha: 1.0).cgColor
        var gradientEndColor = UIColor(red: 5/255.0, green: 117/255.0, blue: 230/255.0, alpha: 1.0).cgColor
            gradientStartColor = UIColor.init(rgb: 0x373B44).cgColor
            gradientEndColor = UIColor.init(rgb: 0x4286f4).cgColor

        gradient = CAGradientLayer()
        guard let gradient = gradient else { return }
        gradient.frame = view.layer.bounds
        gradient.colors = [gradientStartColor, gradientEndColor]
        gradient.startPoint = CGPoint(x: -1, y: -1)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    func setup() {
        timerRest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            roundTimeLabel.text = "Rest Hour"
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            currentTimeLabel.text = timeString
            if count == 0 {
                roundCount += 1
                roundLabel.text = "Round: \(roundCount)"
                timer?.invalidate()
                timerRest?.invalidate()
                count = workTime + 1
                roundTimeLabel.text = "Work Hour"
                timerCounter()
            }
        }
    }
    
    //    MARK: setupUserSchedule
        func setupUserSchedule() {
            if round == 0 {
                setupFinish()
            }
            if count < 0 {
                timer?.invalidate()
                count = restTime
                roundTimeLabel.text = "Rest Hour"
                timer?.invalidate()
                timerRest?.invalidate()
                timerRest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                    count -= 1
                    print("Dinlenme: \(count)")
                    let time = secondsToHoursMinutesSeconds(seconds: count)
                    let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
                    currentTimeLabel.text = timeString
                    if count == 0 {
                        roundCount += 1
                        roundLabel.text = "Round: \(roundCount)"
                        timer?.invalidate()
                        timerRest?.invalidate()
                        count = workTime + 1
                        roundTimeLabel.text = "Work Hour"
                        timerCounter()
                    }
                }
            }
        }
    
    @objc func timerCounter(){
        timer?.invalidate()
        timer = nil
        timerRest?.invalidate()
        timerRest = nil
        if roundTimeLabel.text == "Rest Hour" {
            setup()
        }
        if round > 0 {
            if count == 0 {
                count = workTime + 1
            }
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                count -= 1
                roundTimeLabel.text = "Work Hour"
                print("Çalışma: \(count)")
                if count == 0 {
                    round -= 1
                }
                setupUserSchedule()
            let time = secondsToHoursMinutesSeconds(seconds: count)
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            currentTimeLabel.text = timeString
            }
        }
        else if round == 0 {
            setupFinish()
        }
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
        if isTimerCounting == false {
            isTimerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timerCounter()
        } else {
            isTimerCounting = false
            timer?.invalidate()
            timerRest?.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        }
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.workTimePicker.selectRow(5, inComponent: 0, animated: true)
            self.workTimePicker.selectRow(4, inComponent: 1, animated: true)
            self.workTimePicker.selectRow(5, inComponent: 2, animated: true)
            self.count = 0
            self.roundCount = 1
            self.roundLabel.text = "Round: \(self.roundCount)"
            self.timer?.invalidate()
            self.timerRest?.invalidate()
            self.currentTimeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: PickerView
extension ViewController {
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
        } else if component == 1 {
            workTime = workTimeSchedule.allCases[row].workTimeToSeconds
        } else if component == 2 {
            round = roundSchedule.allCases[row].roundTimes
        } else {
            totalTime = workTimeSchedule.allCases[row].workTimeToSeconds
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            return NSAttributedString(string: restPeriodTimeSchedule.allCases[row].restPeriodTimeText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else if component == 1 {
            return NSAttributedString(string: workTimeSchedule.allCases[row].workTimeText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else if component == 2 {
            return NSAttributedString(string: roundSchedule.allCases[row].roundTimesText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            return NSAttributedString(string: workTimeSchedule.allCases[row].workTimeText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
}

//MARK: Timer Global Func
extension ViewController {
    
    func setupFinish() {
        roundTimeLabel.text = "Finish"
        currentTimeLabel.text = "00 : 00 : 00"
        timer?.invalidate()
        timerRest?.invalidate()
    }
    
    func nukeAllTimer() {
        timer?.invalidate()
        timerRest?.invalidate()
        timer = nil
        timerRest = nil
    }
}

//MARK: Utils
extension ViewController {
    
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
}
