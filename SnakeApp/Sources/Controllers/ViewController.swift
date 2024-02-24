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
        
        let model = Snake.getData()
        snakeView.showFlags(model)
       
//        snakeView.showFlags(positions: [5, 10, 15], max: 20, currentPosition: 17)
        snakeView.flagSelector = { pos in
            print("Pos: \(pos)")
            self.showNotification(title: "Поздравляю", message: "Вы выиграли \(pos) бандлов")
        }
    }
    
    private func showNotification(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
        self.present(alert, animated: true)
    }


}

