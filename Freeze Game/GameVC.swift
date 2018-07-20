
//
//  GameVC.swift
//  Freeze Game
//
//  Created by Yasmine Ghazy on 5/1/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    var no_of_tiles : Int!
    var gameViewWidth : CGFloat!
    var blockWidth : CGFloat!
    var xCenter : CGFloat!
    var yCenter : CGFloat!
    var blocksArr : NSMutableArray = []
    var centersArr : NSMutableArray = []
    var timeCount : Int = 0
    var gameTimer : Timer = Timer()
    var empty : CGPoint!
    var rightBlocks : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBlocks()
        self.resetAction(Any.self)
        
    }
    
    func makeBlocks(){
        
        
        blocksArr = []
        centersArr = []
        no_of_tiles = 16
        let tiles_in_row = Int(sqrt(CGFloat(no_of_tiles)))
        
        gameViewWidth = gameView.frame.size.width
        blockWidth = gameViewWidth / CGFloat(tiles_in_row)
        xCenter = blockWidth / 2
        yCenter = blockWidth / 2
        var labelNum = 1
        
        for _ in 0..<tiles_in_row{
            
            for _ in 0..<tiles_in_row{
                
                let blockFrame : CGRect = CGRect(x: 0, y: 0, width: blockWidth - 4, height: blockWidth - 4)
                let block : MyLabel = MyLabel(frame: blockFrame)
                
                block.text = String(labelNum)
                block.textColor = UIColor.white
                block.textAlignment = NSTextAlignment.center
                block.font = UIFont.systemFont(ofSize: 24)
                block.backgroundColor = UIColor.darkGray
                block.isUserInteractionEnabled = true
                
                let thisCenter : CGPoint = CGPoint(x: xCenter, y: yCenter)
                block.center = thisCenter
                block.originalCenter = thisCenter
                centersArr.add(thisCenter)
                
               
                gameView.addSubview(block)
                blocksArr.add(block)
                
                xCenter = xCenter + blockWidth
                labelNum = labelNum + 1
            }
            
            xCenter = blockWidth / 2
            yCenter = yCenter + blockWidth
        }
        
        let lastBlock : MyLabel = blocksArr[no_of_tiles-1] as!MyLabel
        lastBlock.removeFromSuperview()
        blocksArr.removeObject(at: no_of_tiles-1)
        
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
        
        randomizeAction()
        timeCount = 0
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
    }
    @objc func timerAction(){
        
        timeCount = timeCount + 1
        timerLbl.text = String.init(format: "%02d\"", timeCount)
    }
    
    
    @IBAction func quitAction(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    
    func randomizeAction(){
        
        let tempCentersArr : NSMutableArray = centersArr.mutableCopy() as! NSMutableArray
        for block in blocksArr{
            let randomIndex : Int = Int(arc4random())%tempCentersArr.count
            let randomCenter : CGPoint = tempCentersArr[randomIndex] as!CGPoint
            (block as! MyLabel).center = randomCenter
            tempCentersArr.removeObject(at: randomIndex)
        }
        empty = tempCentersArr[0] as! CGPoint
        
        rightBlocks = 0
        for i in 0..<no_of_tiles-1{
            let block : MyLabel = blocksArr[i]as! MyLabel
            let currentCenters : CGPoint = CGPoint(x: block.center.x , y: block.center.y )
            if (currentCenters == (centersArr[i]as! CGPoint)){
                block.backgroundColor = UIColor.green
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch : UITouch = touches.first!
        if (blocksArr.contains(myTouch.view as Any)){
            
            let touchView : MyLabel = (myTouch.view)! as! MyLabel
            let xDif : CGFloat = touchView.center.x - empty.x
            let yDif : CGFloat = touchView.center.y - empty.y
            let distance = sqrt(pow(xDif, 2)+pow(yDif, 2))
            if(distance == blockWidth){
                
                let tempCent : CGPoint = touchView.center
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                
                touchView.center = empty
                UIView.commitAnimations()
                
                
                if(touchView.originalCenter == empty){
                    touchView.backgroundColor = UIColor.green
                }
                else{
                    touchView.backgroundColor = UIColor.darkGray
                }
                empty = tempCent
           
                rightBlocks = 0
                for i in 0..<no_of_tiles-1{
                    let block : MyLabel = blocksArr[i]as! MyLabel
                    let currentCenters : CGPoint = CGPoint(x: block.center.x , y: block.center.y )
                    if (currentCenters == (centersArr[i]as! CGPoint)){
                        rightBlocks = rightBlocks + 1
                    }
                }
                print(rightBlocks)
                if (rightBlocks == 15){
                    let alert = UIAlertController(title: "Congratulations, You win ^_^", message: "Play again?", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                        self.resetAction(Any.self)
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                         self.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true)
                    
                }
            }
        }
    }
}


class MyLabel : UILabel{
    var originalCenter : CGPoint!
    
}
