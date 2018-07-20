//
//  OptionsVC.swift
//  Freeze Game
//
//  Created by Yasmine Ghazy on 5/4/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {

    @IBOutlet weak var levelSegmentsControl: UISegmentedControl!
    @IBOutlet weak var movesTF: UITextField!
    var level : Int = 0
    var no_of_moves : Int = 50
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func levelSegments(_ sender: Any) {
        level = levelSegmentsControl.selectedSegmentIndex
        
    }

    @IBAction func movesAction(_ sender: Any) {
        
        
        if movesTF.text != nil {
            no_of_moves = Int(movesTF.text!)!
        } else {
            no_of_moves = 50
            movesTF.text = "50"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if movesTF.text != nil {
            no_of_moves = Int(movesTF.text!)!
        } else {
            no_of_moves = 50
            movesTF.text = "50"
        }
        
        level = levelSegmentsControl.selectedSegmentIndex
    }
}
