//
//  InfoViewController.swift
//  bullseyes
//
//  Created by Павел Гордеев on 28.08.17.
//  Copyright © 2017 Павел Гордеев. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func close() {
        dismiss( animated: true )
    }
}
