//
//  ViewController.swift
//  SnakeApp
//
//  Created by  Alexey on 07.02.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var snakeView: SnakeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        snakeView.showFlags(positions: [5, 10, 15], max: 20, currentPosition: 7)
    }


}

