//
//  ContactFormViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/4/22.
//

import Foundation

class ContactFormViewModel {
  let contact: Contact
  let pages: [ContactFormPageViewModel] = []
  var currentPage = 1
  var totalPages: Int { pages.count }

  init(_ contact: Contact) {
    self.contact = contact
  }
}
