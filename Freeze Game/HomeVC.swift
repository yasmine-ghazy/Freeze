//
//  ViewController.swift
//  Freeze Game
//
//  Created by Yasmine Ghazy on 5/1/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    
    var level : Int = 0
    var moves : Int = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func unwindFromOptionsVC(_ sender: UIStoryboardSegue) {
        if sender.source is OptionsVC{
            if let senderVC = sender.source as? OptionsVC{
                level = senderVC.level
                moves = senderVC.no_of_moves
                print(level)
                print(moves)
            }
            
        }
    }



}

