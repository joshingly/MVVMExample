//
//  ContactListDataSource.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

class ContactListDataSource: NSObject, UICollectionViewDataSource {
  let contacts: [String] = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven"]

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(
      UINib(nibName: ContactCell.id, bundle: Bundle.main),
      forCellWithReuseIdentifier: ContactCell.id
    )
  }

  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    contacts.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ContactCell.id,
      for: indexPath
    ) as! ContactCell

    cell.name.text = contacts[indexPath.row]

    return cell
  }
}
