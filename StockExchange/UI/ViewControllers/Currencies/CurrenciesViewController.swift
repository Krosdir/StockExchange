//
//  CurrenciesViewController.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import UIKit

class CurrenciesViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Section, Currency>! = nil
    var collectionView: UICollectionView! = nil
    var refreshControl: UIRefreshControl!
    
    var viewModel: CurrenciesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {
        showActivity()
        viewModel.reloadData()
    }
}

// MARK: - Layout Methods
private extension CurrenciesViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateCollectionLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .dark
        collectionView.registerCell(for: DisabledCurrencyCollectionViewCell.self)
        collectionView.registerCell(for: DelistedCurrencyCollectionViewCell.self)
        collectionView.registerCell(for: FrozenCurrencyCollectionViewCell.self)
        collectionView.registerView(for: HeaderCollectionReusableView.self, of: .header)
        self.collectionView = collectionView
    }
    
    func generateCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.generateLayout(for: self.dataSource.snapshot().sectionIdentifiers[sectionIndex])
        }
        return layout
    }
}

// MARK: - DataSource Methods
private extension CurrenciesViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Currency>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Currency) -> UICollectionViewCell? in
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            guard let sectionModel = self.viewModel.sectionModel(for: section, with: item) else { return nil }
            
            switch sectionModel {
            case .disabled(let viewModel):
                let cell = collectionView.dequeueCell(for: indexPath, with: DisabledCurrencyCollectionViewCell.self)
                cell.update(with: viewModel)
                return cell
            case .delisted(let viewModel):
                let cell = collectionView.dequeueCell(for: indexPath, with: DelistedCurrencyCollectionViewCell.self)
                cell.update(with: viewModel)
                return cell
            case .frozen(let viewModel):
                let cell = collectionView.dequeueCell(for: indexPath, with: FrozenCurrencyCollectionViewCell.self)
                cell.update(with: viewModel)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            let supplementaryView = collectionView.dequeueView(for: indexPath,
                                                               with: HeaderCollectionReusableView.self,
                                                               of: .header)
            supplementaryView.setTitle(with: self.dataSource.snapshot().sectionIdentifiers[indexPath.section].rawValue)
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - CurrenciesViewModelInterfaceDelegate
extension CurrenciesViewController: CurrenciesViewModelInterfaceDelegate {
    func updateInterface(_ sender: Any) {
        updateInterface()
    }
}

// MARK: - Private
private extension CurrenciesViewController {
    func updateInterface() {
        hideActivity()
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Currency> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Currency>()
        for index in 0..<Section.allCases.count {
            let section = Section.allCases[index]
            
            let sectionItems = viewModel.getSnapshotItems(for: section)
            
            snapshot.appendSections([section])
            snapshot.appendItems(sectionItems)
        }
        return snapshot
    }
}
