//
//  EnterWeightViewController.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-21.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit
import Firebase

class EnterWeightViewController: UIViewController {
    
    weak var rootController: MainRootViewController?

    @IBOutlet weak var weightLabel: UILabel!
    
    func close(viewToShow: String) {
        
        rootController?.showView(viewToShow: viewToShow)
        weightLabel.text = "0"
        
    }
    

    
    @IBAction func back(_ sender: Any) {
        
        close(viewToShow: "addEntry")
        
    }
    
    
    
    func addElement(elementToAdd: Character) {
        
        var hasDecimal = false
        var add = true
        
        if weightLabel.text == "0" {
            
            if elementToAdd != "." {
                
                weightLabel.text = String(elementToAdd)

            }

        } else {
            
            if let decimal = weightLabel.text?.contains(".") {
                
                hasDecimal = decimal
                
            }
            
            if hasDecimal {
                if elementToAdd == "." {
                    
                    add = false
                    
                } else if weightLabel.text?.count == 5 {
                    
                    add = false
                    
                }

            } else if weightLabel.text?.count == 3 && elementToAdd != "." {
                
                add = false
                
            }
            
            if add {
                
                weightLabel.text?.append(elementToAdd)
                
            }
            
        }
        
        
        
    }
    
    @IBAction func one(_ sender: Any) {
        
        addElement(elementToAdd: "1")
        
    }
    
    @IBAction func two(_ sender: Any) {
        
        addElement(elementToAdd: "2")
        
    }
    
    @IBAction func three(_ sender: Any) {
        
        addElement(elementToAdd: "3")
        
    }
    
    @IBAction func four(_ sender: Any) {
        
        addElement(elementToAdd: "4")
        
    }
    
    @IBAction func five(_ sender: Any) {
        
        addElement(elementToAdd: "5")
        
    }
    
    @IBAction func six(_ sender: Any) {
        
        addElement(elementToAdd: "6")
        
    }
    
    @IBAction func seven(_ sender: Any) {
        
        addElement(elementToAdd: "7")
        
    }
    
    @IBAction func eight(_ sender: Any) {
        
        addElement(elementToAdd: "8")
    }
    
    @IBAction func nine(_ sender: Any) {
        
        addElement(elementToAdd: "9")
        
    }
    
    @IBAction func zero(_ sender: Any) {
        
        addElement(elementToAdd: "0")
        
    }
    
    @IBAction func decimal(_ sender: Any) {
        
        addElement(elementToAdd: ".")
    }
    
    @IBAction func deleteInput(_ sender: Any) {
        
        if weightLabel.text != "0" {
            
            if weightLabel.text?.count == 1 {
                
                weightLabel.text = "0"
                
            } else {
                
                var hasDecimal = false
                
                if let decimal = weightLabel.text?.contains(".") {
                    
                    hasDecimal = decimal

                }
                
                if hasDecimal {
                    
                    weightLabel.text?.popLast()
                    weightLabel.text?.popLast()
                    
                } else {
                    
                    weightLabel.text?.popLast()
                    
                }
            }
        }
    }
    
    
    @IBAction func enter(_ sender: Any) {
    
        var weight = 0.0
        
        if let textWeight = weightLabel.text {
            
            if let doubleWeight = Double(textWeight) {
                
                weight = doubleWeight
                
            }
        }
        
        if weight != 0 {
        
            let data = ["weight.\(Timestamp())" : weight]
            
            let db = Firestore.firestore()
        
            
            if let id = Auth.auth().currentUser?.uid {
 
                db.collection("users").document(id).updateData(data) { (error) in
                    
                    if let err = error {
                        
                        print(err)
                        
                    } else {
                        
                        self.close(viewToShow: "stats")
    
                    }
                }
            }
        }
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
