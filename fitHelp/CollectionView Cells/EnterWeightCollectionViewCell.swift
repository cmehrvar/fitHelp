//
//  EnterWeightCollectionViewCell.swift
//  fitHelp
//
//  Created by Cina Mehrvar on 2018-10-23.
//  Copyright © 2018 Cina Mehrvar. All rights reserved.
//

import UIKit

class EnterWeightCollectionViewCell: UICollectionViewCell {
    
    weak var addEntryController: AddEntryViewController?
    
    @IBOutlet weak var enterWeightOutlet: UIButton!
    
    @IBAction func enterWeight(_ sender: Any) {
        
        addEntryController?.rootController?.showView(viewToShow: "enterWeight")
        
        
    }
    
    
    
}
