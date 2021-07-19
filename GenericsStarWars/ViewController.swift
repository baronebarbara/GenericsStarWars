//
//  ViewController.swift
//  GenericsStarWars
//
//  Created by Barbara Barone on 18/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Service<Repository>().method { result in
            switch result {
            case .success(let repository):
                print(repository)
            case .failure(let error):
                print(error)
            }
        }
    }


}

