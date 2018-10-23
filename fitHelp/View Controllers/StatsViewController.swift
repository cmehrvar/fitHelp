//
//  StatsViewController.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-21.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var rootController: MainRootViewController?
    
    @IBOutlet weak var timeRangeOutlet: UILabel!
    @IBOutlet weak var currentTimeRange: UILabel!
    @IBOutlet weak var pastTimeRange: UILabel!
    @IBOutlet weak var changeTimeRange: UILabel!
    
    @IBOutlet weak var pastWeight: UILabel!
    @IBOutlet weak var currentWeight: UILabel!
    @IBOutlet weak var changeInWeight: UILabel!
    
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 6
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            
            handleWeight(timePeriod: 1)
            
        } else if row == 1 {
            
            handleWeight(timePeriod: 3)
            
        } else if row == 2 {
            
            handleWeight(timePeriod: 7)
            
        } else if row == 3 {
            
            handleWeight(timePeriod: 30)
            
        } else if row == 4 {
            
            handleWeight(timePeriod: 90)
            
            
        } else if row == 5 {
            
            handleWeight(timePeriod: 182)
            
        }
        
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            
            return "1 Day"
            
        } else if row == 1 {
            
            return "3 Days"
            
        } else if row == 2 {
            
            return "1 Week"
            
        } else if row == 3 {
            
            return "1 Month"
            
        } else if row == 4 {
            
            return "3 Months"
            
            
        } else if row == 5 {
            
            return "6 Months"
            
        }
    
        return ""
        
    }
    

    
    func handleWeight(timePeriod: Double){
        
        if timePeriod == 1 {
            
            timeRangeOutlet.text = "1 Day"
            pastTimeRange.text = "Prior Day"
            currentTimeRange.text = "Past Day"
            changeTimeRange.text = "1 Day Change"
            
        } else if timePeriod == 3 {
            
            timeRangeOutlet.text = "3 Days"
            pastTimeRange.text = "Prior 3 Days"
            currentTimeRange.text = "Past 3 Days"
            changeTimeRange.text = "3 Day Change"
            
        } else if timePeriod == 7 {
            
            timeRangeOutlet.text = "7 Days"
            pastTimeRange.text = "Prior 7 Days"
            currentTimeRange.text = "Past 7 Days"
            changeTimeRange.text = "1 Week Change"
            
        } else if timePeriod == 30 {
            
            timeRangeOutlet.text = "1 Month"
            pastTimeRange.text = "Prior Month"
            currentTimeRange.text = "Past Month"
            changeTimeRange.text = "1 Month Change"
            
        } else if timePeriod == 90 {
            
            timeRangeOutlet.text = "3 Months"
            pastTimeRange.text = "Prior 3 Months"
            currentTimeRange.text = "Past 3 Months"
            changeTimeRange.text = "3 Month Change"
            
        } else if timePeriod == 182 {
            
            timeRangeOutlet.text = "6 Months"
            pastTimeRange.text = "Prior 6 Months"
            currentTimeRange.text = "Past 6 Months"
            changeTimeRange.text = "6 Month Change"
            
        }
        
        
        if let data = rootController?.userData {
            
            if let userWeight = data["weight"] as? [String:Double] {

                var currentPeriod: Double = 0
                var currentPeriodCount: Double = 0
                
                var lastPeriod: Double = 0
                var lastPeriodCount: Double = 0
                
                for weight in userWeight {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
                    let date = dateFormatter.date(from: weight.key)
                    
                    guard let timeSinceNow = date?.timeIntervalSince(Date()) else {return}
                    let formattedTimeSinceNow = -(((timeSinceNow/60)/60)/60)
                    
                    print(formattedTimeSinceNow)
                    print(timePeriod)
                    
                    if formattedTimeSinceNow <= timePeriod {
                        
                        currentPeriod += weight.value
                        currentPeriodCount += 1
                        
                    } else if formattedTimeSinceNow <= (timePeriod*2) {
                        
                        lastPeriod += weight.value
                        lastPeriodCount += 1
                        
                    }
                }
                
                currentPeriod = ((currentPeriod/currentPeriodCount)*10).rounded()
                currentPeriod /= 10
                lastPeriod = ((lastPeriod/lastPeriodCount)*10).rounded()
                lastPeriod /= 10
                
                var change = currentPeriod/lastPeriod
                change = 1 - change
                change = (change*1000).rounded()
                change /= 10

                if lastPeriodCount == 0 {
                    
                    pastWeight.text = "N/A"
                    changeInWeight.text = "N/A"
                    
                } else {
                    
                    pastWeight.text = "\(lastPeriod) lbs"
                    changeInWeight.text = "\(change) %"
                    
                }
                
                
                currentWeight.text = "\(currentPeriod) lbs"
                
                
            }
        }
    }
    
    func updateStats() {
        
        handleWeight(timePeriod: 3)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
