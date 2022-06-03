//
//  ContactListCollectionViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

class ContactListViewController: UICollectionViewController {
  let data = ContactListDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.dataSource = data
    collectionView.delegate = self
    data.registerCells(for: collectionView)

    setup()
  }

  func setup() {
    setupNavBar()
  }

  func setupNavBar() {
    navigationItem.title = "Contacts"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addPressed)
    )
  }

  @objc func addPressed() { print("pressed") }
}
