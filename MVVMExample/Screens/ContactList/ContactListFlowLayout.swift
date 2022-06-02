//
//  ContactListFlowLayout.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

private typealias ContactListFlowLayout = ContactListViewController
extension ContactListFlowLayout: UICollectionViewDelegateFlowLayout {
  private enum Layout {
    static let spacing: CGFloat = 10.0
    static let cellHeight: CGFloat = 200.0
  }

  func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
    let width = cellWidth(for: view.frame.width, spacing: Layout.spacing)

    return CGSize(width: width, height: Layout.cellHeight)
  }

  func cellWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
    let cellsPerRow: CGFloat = 2

    let totalSpacing: CGFloat = 2 * spacing + (cellsPerRow - 1) * spacing
    let totalWidth = (width - totalSpacing) / cellsPerRow

    return floor(totalWidth)
  }

  func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
    UIEdgeInsets(
      top: Layout.spacing,
      left: Layout.spacing,
      bottom: Layout.spacing,
      right: Layout.spacing
    )
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    minimumLineSpacingForSectionAt _: Int
  ) -> CGFloat {
    Layout.spacing
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt _: Int
  ) -> CGFloat {
    Layout.spacing
  }
}
