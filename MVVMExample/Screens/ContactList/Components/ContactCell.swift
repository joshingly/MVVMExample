//
//  ContactCell.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

class ContactCell: UICollectionViewCell {
  @IBOutlet var name: UILabel! { didSet { name.textColor = .white } }

  static var id: String {
    String(describing: self)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
  }

  func setup() {
    backgroundColor = .blue
  }
}
