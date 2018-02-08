//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Scott Higgins on 2/3/18.
//  Copyright © 2018 ScottieH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eightBallImage: UIImageView!
    
    let ballArray: [String] = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomBallNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRandomBall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askButtonPressed(_ sender: UIButton) {
        setRandomBall()
    }
    
    func setRandomBall() {
        randomBallNumber = Int(arc4random_uniform(5))
        eightBallImage.image = UIImage(named: ballArray[randomBallNumber])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        setRandomBall()
    }
    
}

