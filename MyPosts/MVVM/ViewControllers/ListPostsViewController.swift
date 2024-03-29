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


class ListPostsViewController: UITableViewController{
    
    @IBOutlet var tableViewCell: UITableView!
    
    private var postsViewModel = PostsViewModel()
    private let disposedBag = DisposeBag()
    private var dataForTableOfPosts: [Post] = []
    private var persistenceManager = PersistenceManager.shared
    var countCell: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    private func bind() {
        postsViewModel.output.isPostsRecived.subscribe(
            onNext: { isPostsReived in
                
                if isPostsReived == true {
                    self.callDataForCells(position: self.dataForTableOfPosts.count - 1)
                }
            
        }).disposed(by: disposedBag)
        
        
        //Change color when cell is read
        tableViewCell.rx.itemSelected.subscribe(
            onNext: {
                [weak self] indexPath in
                if let cell = self?.tableViewCell.cellForRow(at: indexPath) as? TablePostsViewCell {
                    cell.contentView.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
                    self!.dataForTableOfPosts[indexPath.row].read = true
                    self!.persistenceManager.saveContext()
                    self!.tableViewCell.deselectRow(at: indexPath, animated: false)
                }
                
        }).disposed(by: disposedBag)
        
        //tableViewCell.rx.setDelegate(self).disposed(by: disposedBag)
        //tableViewCell.rx.setDataSource(self).disposed(by: disposedBag)
        
    }
    
    private func callDataForCells(position: Int) {
        for data in postsViewModel.output.postsFromCoreData.value {
            dataForTableOfPosts.append(data)
            addInformationInCell(position: position)
        }
    }
    
    func addInformationInCell(position: Int) {
        let indexPath = IndexPath(row: position, section: 0)
        
        tableViewCell.beginUpdates()
        tableViewCell.insertRows(at: [indexPath], with: .automatic)
        tableViewCell.endUpdates()
    }
    
    private func selectImage(id: Int) -> UIImage {
        switch id {
        case 1,4,7,10 :
            return UIImage(named: "User3", in: Bundle.main, compatibleWith: nil)!
        case 2,5,8 :
            return UIImage(named: "User2", in: Bundle.main, compatibleWith: nil)!
        case 3,6,9:
            return UIImage(named: "User1", in: Bundle.main, compatibleWith: nil)!
        
        default:
            return UIImage(named: "User3", in: Bundle.main, compatibleWith: nil)!
        }
    }

    
    
}

extension ListPostsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableOfPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TablePostsViewCell else {
            return TablePostsViewCell()
        }
        
        let post = dataForTableOfPosts[indexPath.row]
        
        cell.imageUser.image = self.selectImage(id: Int(post.userId))
        cell.labelTitle.text = post.title
        cell.labelDescription.text = post.body
        
        if countCell <= 19 && post.read == false {
            cell.contentView.backgroundColor = UIColor(red: 60 / 255, green: 136 / 255, blue: 246 / 255, alpha: 1)
            countCell += 1
        } else {
            cell.contentView.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        }
        
        return cell
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Borrar") { (action, indexpath) in
            
            self.persistenceManager.delete(self.dataForTableOfPosts[indexPath.row])
            self.dataForTableOfPosts.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
        }
        
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = dataForTableOfPosts[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PerfilViewController") as? PerfilViewController
        vc?.image = self.selectImage(id: Int(dataForTableOfPosts[indexPath.row].userId))
        vc?.idUser = "\(String(describing: post.userId))"
        vc?.idPost = "\(String(describing: post.id))"
        vc?.tittle = post.title!
        vc?.descriptionPost = post.body!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
