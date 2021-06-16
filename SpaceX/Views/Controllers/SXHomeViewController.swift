//
//  SXHomeViewController.swift
//  SpaceX
//
//  Created by Abbut john on 11/06/2021.
//

import UIKit
import SwiftUI

class SXHomeViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var activityView: UIActivityIndicatorView?
    var viewModel : SXHomeViewModel!

    //MARK:LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.showActivityIndicator()
        tableView.register(UINib(nibName: "SXRocketTableViewCell", bundle: nil), forCellReuseIdentifier: "SXRocketTableViewCell")

    }
    
    //MARK:Binding with ViewModel
    
    func bindViewModel(){
        self.viewModel =  SXHomeViewModel()
        self.viewModel.loadData = {
            self.tableView.reloadData()
        }
        self.viewModel.hideActivityIndicator = {
            self.hideActivityIndicator()
        }
    }
    
    //MARK:Funtions

    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        activityView?.color = .white
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}

//MARK:TableViewcontroller

extension SXHomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowsPerSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SXRocketTableViewCell") as! SXRocketTableViewCell
        cell.viewModel = self.viewModel.viewModelForCell(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocketData = self.viewModel.viewModelForCell(at: indexPath.row)
        let vc = UIHostingController(rootView: SXDetailsView(rocket: rocketData))
        present(vc, animated: true)
    }
}




