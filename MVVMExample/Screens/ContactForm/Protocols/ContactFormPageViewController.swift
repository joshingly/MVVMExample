//
//  ContactFormPageViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/6/22.
//

import Foundation
import UIKit

protocol ContactFormPageViewController: UIViewController {
  var _viewModel: ContactFormPageViewModel! { get set }
}
