//
//  ContactFormPageViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/6/22.
//

import Foundation

protocol ContactFormPageViewModel {
  var contact: Contact! { get set }

  func save() -> Void
}
