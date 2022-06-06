//
//  ContactFormPageOneViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormPageOneViewController: UIViewController, ContactFormPageViewController {
  var _viewModel: ContactFormPageViewModel! = ContactFormPageOneViewModel()
  var viewModel: ContactFormPageOneViewModel { _viewModel as! ContactFormPageOneViewModel }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    view.backgroundColor = .magenta
  }
}
