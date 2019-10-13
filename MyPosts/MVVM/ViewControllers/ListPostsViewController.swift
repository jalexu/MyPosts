//
//  ListPostsViewController.swift
//  MyPosts
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class ListPostsViewController: UIViewController {
    
    @IBOutlet weak var btnShowPosts: UIButton!
    
    private var postsViewModel = PostsViewModel()
    private let disposed = DisposeBag()
    private var dataForTableOfPosts: [ResponseGetData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.propertiesButtonShowPosts()
        self.bind()

    }
    
    private func bind() {
        postsViewModel.output.isPostsReived.subscribe(
            onNext: { isPostsReived in
                
                if isPostsReived == true {
                    self.callDataForCells(position: self.dataForTableOfPosts.count - 1)
                }
            
        }).disposed(by: disposed)
        
    }
    
    private func callDataForCells(position: Int) {
        for data in postsViewModel.output.postsReceived.value {
            dataForTableOfPosts.append(data)
            //addInformationInCell(position: position)
        }
    }
    
    private func propertiesButtonShowPosts(){
        btnShowPosts.layer.borderWidth = 1.0
        btnShowPosts.layer.cornerRadius = 12
        btnShowPosts.layer.borderColor = UIColor.white.cgColor
    }
    



}
