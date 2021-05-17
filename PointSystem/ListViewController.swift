//
//  ListViewController.swift
//  PointSystem
//
//  Created by jpg on 2017/10/10.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import UIKit
import Foundation
class ListViewController:UIViewController{
    var account:Account?
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var pointText: UILabel!
    @IBOutlet weak var weekpointText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeText.text = welcomeText.text!+","+account!.chinesename
    }
}
