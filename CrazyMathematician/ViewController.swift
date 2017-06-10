//
//  ViewController.swift
//  CrazyMathematician
//
//  Created by Aibek Rakhim on 6/8/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var firstLVLbutton: UIButton!
    @IBOutlet weak var secondLVLbutton: UIButton!
    @IBOutlet weak var thirdLVLbutton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var bestScore = 0
    var didSelected = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //for saving primitive data types
        bestScore = UserDefaults.standard.integer(forKey: "best")
//        UserDefaults.standard.object(forKey: "results")
        self.bestScoreLabel.text = "\(bestScore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButton(_ sender: UIButton) {
        
        if didSelected {
            startButton.isEnabled = false
            if firstLVLbutton.isSelected == true || secondLVLbutton.isSelected == true || (thirdLVLbutton.isSelected == true) {
                startButton.isEnabled = true
                performSegue(withIdentifier: "toGameVC", sender: nil)
            } else {
                startButton.isEnabled = false
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // проверка seque тот или нет
        
        if (segue.destination.isKind(of: GameViewController.self)) {
            let gameVC = segue.destination as! GameViewController
            // we write the code to call method GAMESCORE else it will be nil
            //TODO
            if firstLVLbutton.isSelected {
                gameVC.level = 1
            }
            else if secondLVLbutton.isSelected {
                gameVC.level = 2
            } else if thirdLVLbutton.isSelected {
                gameVC.level = 3
            }
            gameVC.delegate = self
        }

    }
    
    // level buttons
    
    @IBAction func firstLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = true
        secondLVLbutton.isSelected = false
        thirdLVLbutton.isSelected = false
    }
    
    @IBAction func secondLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = false
        secondLVLbutton.isSelected = true
        thirdLVLbutton.isSelected = false
    }
    
    @IBAction func thirdLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = false
        secondLVLbutton.isSelected = false
        thirdLVLbutton.isSelected = true
    }
    
    @IBAction func allScoresBTNpressed(_ sender: UIButton) {
        
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

extension ViewController: GameVCDelegate {
    func gameScore(score: Int) {
        
        if (score > bestScore) {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "best")
        }
        
        self.bestScoreLabel.text = "\(bestScore)"
    }
}

