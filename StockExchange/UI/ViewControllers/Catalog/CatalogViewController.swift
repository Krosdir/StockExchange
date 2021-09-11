//
//  CatalogViewController.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Alamofire
import UIKit

class TradeHistoryViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: TradeHistoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomNetworkService.shared.query { result in
            
        }
    }
    
    func reloadData() {
        viewModel.reloadData()
    }

}

extension TradeHistoryViewController: UITableViewDataSource {
    
}

// MARK: - TradeHistoryViewModelInterfaceDelegate
extension TradeHistoryViewController: TradeHistoryViewModelInterfaceDelegate {
    
}
