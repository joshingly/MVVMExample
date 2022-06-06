//
//  ContactFormPageTwoViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormPageTwoViewController: UIViewController, ContactFormPageViewController {
  var _viewModel: ContactFormPageViewModel! = ContactFormPageTwoViewModel()
  var viewModel: ContactFormPageTwoViewModel { _viewModel as! ContactFormPageTwoViewModel }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    view.backgroundColor = .green
  }
}
