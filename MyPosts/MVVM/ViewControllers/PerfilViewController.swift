//
//  PerfilViewController.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/13/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    
    @IBOutlet weak var idUserLabel: UILabel!
    @IBOutlet weak var idPostLabel: UILabel!
    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var descriptionPostLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    var idUser = ""
    var idPost = ""
    var tittle = ""
    var descriptionPost = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idUserLabel.text = idUser as String
        idPostLabel.text = Optional (idPost)
        titlePostLabel.text = tittle
        descriptionPostLabel.text = descriptionPost
        imageUser.image = image
    }
    

}
