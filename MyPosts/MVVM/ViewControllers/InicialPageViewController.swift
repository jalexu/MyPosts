//
//  InicialPageViewController.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/13/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import UIKit

class InicialPageViewController: UIViewController {
    
    
    @IBOutlet weak var btnShowPosts: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.propertiesButtonShowPosts()
    }
    
    private func propertiesButtonShowPosts(){
        btnShowPosts.layer.borderWidth = 1.0
        btnShowPosts.layer.cornerRadius = 12
        btnShowPosts.layer.borderColor = UIColor.white.cgColor
    }


}
