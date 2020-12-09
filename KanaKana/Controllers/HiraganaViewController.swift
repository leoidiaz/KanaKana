//
//  HiraganaViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class HiraganaViewController: UIViewController {
    //MARK: - Properties
    private let reuseIdentifier = "kanaCell"
    let hiraganaManager = HiraganaManager.shared
    private var types = [Type]()
    var collectionView: UICollectionView!
    var filterSegment: UISegmentedControl!
    private lazy var dataSource = makeDataSource()
    typealias DataSource = UICollectionViewDiffableDataSource<Type, Hiragana>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Type, Hiragana>
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configFilterSegment()
        configCollectionView()
        layout()
        fetchAllHiragana()
    }
    //MARK: - Methods
    private func fetchAllHiragana(){
        hiraganaManager.fetchHiragana { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let types):
                    self?.types = types
                    self?.applySnapshot(animatingDifferences: false)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    private func layout(){
        filterSegment.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: filterSegment.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
    //MARK: - CollectionView Methods
extension HiraganaViewController: UICollectionViewDelegate {
    
    private func configCollectionView(){
        let layout = layoutCollectionView(sender: true)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.reuseIdentifier)
        collectionView.register(HiraganaCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let kana = dataSource.itemIdentifier(for: indexPath) else { return }
        showDetails(kana)
    }
    
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, hiragana) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HiraganaCollectionViewCell else { return UICollectionViewCell()}
            cell.hiragana = hiragana
            return cell
        })
        if filterSegment.selectedSegmentIndex == 0 {
            return dataSource
        } else {
            dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
                guard kind == UICollectionView.elementKindSectionHeader else { return nil }
                let section = self?.dataSource.snapshot()
                    .sectionIdentifiers[indexPath.section]
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.reuseIdentifier, for: indexPath) as? HeaderReusableView
                view?.titleLabel.text = section?.type.uppercased()
                return view
            }
            return dataSource
        }
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(types)
        types.forEach { type in
            snapshot.appendItems(type.hiragana, toSection: type)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    

    func layoutCollectionView(sender: Bool) -> UICollectionViewLayout {
        if sender {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.33))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        } else {
            let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                let size = NSCollectionLayoutSize(
                    widthDimension: NSCollectionLayoutDimension.absolute(90),
                    heightDimension: NSCollectionLayoutDimension.absolute(180)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10)
                section.interGroupSpacing = 10
                let headerFooterSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(20)
                )
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return section
            })
            return layout
        }
    }
}
    //MARK: - Segmented Controller Methods
extension HiraganaViewController {
    private func configFilterSegment(){
        let segmentItems = ["All", "Types"]
        filterSegment = UISegmentedControl(items: segmentItems)
        filterSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.systemBackground], for: .selected)
        filterSegment.selectedSegmentTintColor = .gris
        filterSegment.selectedSegmentIndex = 0
        filterSegment.addTarget(self, action: #selector(segmentToggled(_:)), for: .valueChanged)
        view.addSubview(filterSegment)
    }
    
    @objc private func segmentToggled(_ sender: UISegmentedControl){
        dataSource.supplementaryViewProvider = nil
        dataSource = makeDataSource()
        if sender.selectedSegmentIndex == 0 {
            collectionView.collectionViewLayout = layoutCollectionView(sender: true)
        } else {
            collectionView.collectionViewLayout = layoutCollectionView(sender: false)
        }
        applySnapshot()
    }
}

    //MARK: - Show Details
extension HiraganaViewController {
    private func showDetails(_ kana: Hiragana){
        let detailsView = DetailsView()
        detailsView.kanaText.text = kana.kana
        detailsView.romajiText.text = kana.romaji
        detailsView.typeText.text = kana.type
        tabBarController?.view.addSubview(detailsView)
    }
    
}
