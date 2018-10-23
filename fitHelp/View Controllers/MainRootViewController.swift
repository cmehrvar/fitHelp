//
//  MainRootViewController.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-16.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit
import Firebase

class MainRootViewController: UIViewController {
    
    let email = "cmehrvar@ryerson.ca"
    let password = "cousinhadI@1"
    
    @IBOutlet weak var enterWeightView: UIView!
    @IBOutlet weak var addEntryView: UIView!
    @IBOutlet weak var statsView: UIView!
    
    var views = [UIView]()
    
    weak var addEntryController: AddEntryViewController?
    weak var statsController: StatsViewController?
    weak var enterWeightController: EnterWeightViewController?
    weak var bottomBarController: BottomBarViewController?
    
    var userData: [String:Any]?
    
    func getData() {
        
        if let id = Auth.auth().currentUser?.uid {
            
            let ref = Firestore.firestore().collection("users").document(id)
            
            ref.addSnapshotListener { (document, error) in
                
                if let doc = document?.data() {
                    
                    self.userData = doc
                    self.statsController?.updateStats()
                    
                } else {
                    
                    print("no data")
                    
                }
                
            }
            
        }
        
    }
    
    func showView(viewToShow: String) {
        
        var tag = 0
        
        if viewToShow == "stats" {
            
            tag = 1
            
        } else if viewToShow == "addEntry" {
            
            tag = 2
            
        } else if viewToShow == "enterWeight" {
            
            tag = 3
            
        }
        
        for view in views {
            
            if view.tag == tag {
                
                view.alpha = 1
                
            } else {
                
                view.alpha = 0
                
            }
        }
    }
    
    
    func setUpViews(){
        
        views.append(statsView)
        views.append(addEntryView)
        views.append(enterWeightView)
        
        for view in views {
            
            if view.tag == 1 {
                
                view.alpha = 1
                
            } else {
                
                view.alpha = 0
                
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUpViews()
        getData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addEntrySegue" {
            
            let addEntry = segue.destination as? AddEntryViewController
            addEntryController = addEntry
            addEntryController?.rootController = self
            
        } else if segue.identifier == "statsSegue" {
            
            let stats = segue.destination as? StatsViewController
            statsController = stats
            statsController?.rootController = self
        
        } else if segue.identifier == "enterWeightSegue" {
            
            let weight = segue.destination as? EnterWeightViewController
            enterWeightController = weight
            enterWeightController?.rootController = self
            
        } else if segue.identifier == "bottomBarSegue" {
            
            let bottomBar = segue.destination as? BottomBarViewController
            bottomBarController = bottomBar
            bottomBarController?.rootController = self
            
        }
    }
}
