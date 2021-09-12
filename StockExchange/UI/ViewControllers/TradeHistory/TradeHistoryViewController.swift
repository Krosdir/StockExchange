//
//  CatalogViewController.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class TradeHistoryViewController: UIViewController {
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: TradeHistoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        reloadData()
    }
    
    func reloadData() {
        showActivity()
        viewModel.reloadData()
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        viewModel.updateHistoryType(with: sender.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDataSource
extension TradeHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.cellViewModel(for: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueCell(for: indexPath, with: TradeTableViewCell.self)
        cell.update(with: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TradeHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerViewModel = viewModel.getHeaderViewModel(for: section) else { return nil }
        let header = tableView.dequeueView(with: TradeTableViewSectionHeader.self)
        header.update(with: headerViewModel)
        return header
    }
}

// MARK: - TradeHistoryViewModelInterfaceDelegate
extension TradeHistoryViewController: TradeHistoryViewModelInterfaceDelegate {
    func updateInterface(_ sender: Any) {
        updateInterface()
    }
    
    func viewModel(_ viewModel: TradeHistoryViewModel, attemptsToReloadSection section: Int) {
        updateSection(section)
    }
}

// MARK: - Private
private extension TradeHistoryViewController {
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerCell(with: TradeTableViewCell.self)
        tableView.registerView(with: TradeTableViewSectionHeader.self)
        
        segmentControl.removeAllSegments()
        for index in 0..<TradeHistoryType.allCases.count {
            let type = TradeHistoryType.allCases[index]
            segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
    }
    
    func updateSection(_ section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func updateInterface() {
        hideActivity()
        tableView.reloadData()
    }
}
