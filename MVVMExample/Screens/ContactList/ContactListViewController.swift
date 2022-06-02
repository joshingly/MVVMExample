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
  }
}
