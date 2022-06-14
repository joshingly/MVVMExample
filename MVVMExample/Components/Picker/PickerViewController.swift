//
//  PickerViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/12/22.
//

import Foundation
import UIKit

private enum Section: Int, Hashable {
  case main = 0
}

private struct Item: Hashable {
  let id: Int
  let externalId: String
  let value: String
  let selected: Bool
}

struct PickerOption {
  let id: String
  let name: String
}

class PickerViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate {
  private var allItems: [Item] = []
  private var filter: (([Item]) -> [Item])?
  private var visibleItems: [Item] {
    if let filter = filter { return filter(allItems) }
    else { return allItems }
  }

  var selectionCallback: (PickerOption?) -> Void = { _ in }

  @IBOutlet var searchBar: UISearchBar! { didSet { searchBar.delegate = self }}
  @IBOutlet var collectionView: UICollectionView! { didSet {
    collectionView.delegate = self
    let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
    reloadData(animate: false)
  } }

  private let cellRegistration = UICollectionView.CellRegistration<
    UICollectionViewListCell, Item
  > { cell, _, item in
    var config = cell.defaultContentConfiguration()
    config.text = item.value
    config.textProperties.color = .black
    cell.contentConfiguration = config

    let selectedBG = UIView(frame: cell.bounds)
    selectedBG.backgroundColor = .systemBlue
    cell.selectedBackgroundView = selectedBG
  }

  private lazy var dataSource = {
    UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: self.collectionView
    ) { [unowned self] (
      collectionView: UICollectionView,
      indexPath: IndexPath,
      item: Item
    ) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(
        using: self.cellRegistration,
        for: indexPath,
        item: item
      )
    }
  }()

  static func get(
    items: [PickerOption],
    selectedIndex: Int? = nil,
    _ callback: @escaping (PickerOption?) -> Void
  ) -> UIViewController {
    let storyboard = UIStoryboard(name: "Picker", bundle: Bundle.main)
    let navVC = storyboard.instantiateInitialViewController() as! UINavigationController
    let vc = navVC.viewControllers[0] as! PickerViewController

    vc.selectionCallback = callback
    vc.allItems = items.enumerated().map { i, option in
      .init(id: i, externalId: option.id, value: option.name, selected: i == selectedIndex)
    }

    let _ = vc.view

    if let selectedIndex = selectedIndex {
      let indexPath = IndexPath(row: selectedIndex, section: Section.main.rawValue)
      vc.collectionView.selectItem(
        at: indexPath,
        animated: false,
        scrollPosition: .top
      )
    }
    return navVC
  }

  func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    self.view.isUserInteractionEnabled = false

    selectionCallback(.init(id: item.externalId, name: item.value))
    self.dismiss(animated: true)
  }

  func searchBar(_: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty { filter = nil }
    else {
      filter = { items in
        let format = "\(NSRegularExpression.escapedPattern(for: searchText))"
        return items.compactMap { item in
          if item.value.range(of: format, options: [.regularExpression, .caseInsensitive]) != nil {
            return item
          } else { return nil }
        }
      }
    }

    reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    setupNavBar()
  }

  func setupNavBar() {
    navigationItem.title = "Picker"
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelPressed)
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Clear",
      style: .plain,
      target: self,
      action: #selector(clearPressed)
    )
  }

  func reloadData(animate: Bool = true) {
    var snapshot = dataSource.snapshot()
    snapshot.deleteAllItems()
    snapshot.appendSections([.main])
    snapshot.appendItems(visibleItems, toSection: .main)

    dataSource.apply(snapshot, animatingDifferences: animate)
  }

  @objc func cancelPressed() {
    if let item = allItems.first(where: { $0.selected }) {
      selectionCallback(.init(id: item.externalId, name: item.value))
    }

    dismiss(animated: true)
  }

  @objc func clearPressed() {
    selectionCallback(nil)

    dismiss(animated: true)
  }
}
