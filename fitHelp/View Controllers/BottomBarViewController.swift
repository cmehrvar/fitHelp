//
//  TopBarViewController.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-23.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit

class BottomBarViewController: UIViewController {
    
    weak var rootController: MainRootViewController?
    
    @IBAction func showStats(_ sender: Any) {
        
        rootController?.showView(viewToShow: "stats")
        
    }
    
    
    @IBAction func showAddEntry(_ sender: Any) {
        
        rootController?.showView(viewToShow: "addEntry")
        
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
