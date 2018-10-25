//
//  StatsViewController.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-21.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit
import Firebase

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
    

    
    func handleWeight(timePeriod: Int){
        
        if timePeriod == 1 {
            
            timeRangeOutlet.text = "1 Day"
            pastTimeRange.text = "Yesterday Avg"
            currentTimeRange.text = "Today Avg"
            changeTimeRange.text = "1 Day Change"
            
        } else if timePeriod == 3 {
            
            timeRangeOutlet.text = "3 Days"
            pastTimeRange.text = "Prior 3 Day Avg"
            currentTimeRange.text = "3 Day Avg"
            changeTimeRange.text = "3 Day Change"
            
        } else if timePeriod == 7 {
            
            timeRangeOutlet.text = "1 Week"
            pastTimeRange.text = "Last Week Avg"
            currentTimeRange.text = "This Week Avg"
            changeTimeRange.text = "Weekly Change"
            
        } else if timePeriod == 30 {
            
            timeRangeOutlet.text = "1 Month"
            pastTimeRange.text = "Last Month Avg"
            currentTimeRange.text = "This Month Avg"
            changeTimeRange.text = "Monthly Change"
            
        } else if timePeriod == 90 {
            
            timeRangeOutlet.text = "3 Months"
            pastTimeRange.text = "Prior 3 Month Avg"
            currentTimeRange.text = "3 Month Avg"
            changeTimeRange.text = "3 Month Change"
            
        } else if timePeriod == 182 {
            
            timeRangeOutlet.text = "6 Months"
            pastTimeRange.text = "Prior 6 Month Avg"
            currentTimeRange.text = "6 Month Avg"
            changeTimeRange.text = "6 Month Change"
            
        }
        
        
        if let data = rootController?.userData {

            if let userWeight = data["weight"] as? [AnyHashable:Double] {
                
                var weightValues = [Int:[Double]]()
                
                for weight in userWeight {
                    
                    var date = Date()
                    
                    if let value = weight.key as? Timestamp {
                        
                        date = value.dateValue()
                        
                    } else if let value = weight.key as? String {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
                  
                        if let tempDate = dateFormatter.date(from: value){
                            
                            date = tempDate
                            
                        }
                    }

                    let interval = Calendar.current.dateComponents([.day, .month, .year], from: date, to: Date())
  
                    if let day = interval.day, let month = interval.month, let year = interval.year {
                        
                        let daysAgo = day + (month*30) + (year*365)
                        
                        if weightValues[daysAgo] == nil {
                            
                            weightValues[daysAgo] = [weight.value]
                            
                        } else {
                            
                            weightValues[daysAgo]?.append(weight.value)
                            
                        }
                    }
                }
                
                var avgWeightValues = [Int:Double]()
                
                for values in weightValues {
                    
                    var avg:Double = 0
                    
                    for value in values.value {
                        
                        avg += value
                        
                    }
                    
                    avg /= Double(values.value.count)
                    
                    avgWeightValues[values.key] = avg
                    
                }
                
                
                var currentPeriod = [Double]()
                var lastPeriod = [Double]()

                for value in avgWeightValues {
                    
                    if value.key < timePeriod {
                        
                        currentPeriod.append(value.value)
                        
                    } else if value.key >= timePeriod && value.key < (timePeriod*2) {
                        
                        lastPeriod.append(value.value)
                        
                    }
                }
                
                var currentAvg: Double = 0
                var lastAvg: Double = 0
                
                for value in currentPeriod {
                    
                    currentAvg += value
                    
                }
                
                for value in lastPeriod {
                    
                    lastAvg += value
                    
                }
                
                currentAvg /= Double(currentPeriod.count)
                lastAvg /= Double(lastPeriod.count)
                
                
                currentAvg = (currentAvg*10).rounded()
                currentAvg /= 10
                lastAvg = (lastAvg*10).rounded()
                lastAvg /= 10
                
                var change = currentAvg/lastAvg
                change = 1 - change
                change = (change*1000).rounded()
                change /= 10
                change = -change

                if lastPeriod.count == 0 {
                    
                    pastWeight.text = "N/A"
                    pastWeight.textColor = UIColor.lightGray
                    changeInWeight.text = "N/A"
                    changeInWeight.textColor = UIColor.lightGray
                    
                } else {
                    
                    pastWeight.text = "\(lastAvg) lbs"
                    pastWeight.textColor = UIColor.white
                    
                    if change > 0 {
                        
                        changeInWeight.text = "+\(change) %"
                        changeInWeight.textColor = UIColor.red
                        
                    } else if change < 0 {
                        
                        changeInWeight.text = "\(change) %"
                        changeInWeight.textColor = UIColor.green
                        
                    }
                }

                currentWeight.text = "\(currentAvg) lbs"
   
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
