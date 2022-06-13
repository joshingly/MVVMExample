//
//  ContactFormViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/4/22.
//

import Foundation

class ContactFormViewModel {
  let contact: Contact
  var pages: [ContactFormPageViewModel] = []
  var currentPage = 1
  var totalPages: Int { pages.count }

  var UIscrollToPage: (Int) -> Void = { _ in }

  init(_ contact: Contact) {
    self.contact = contact
  }

  func canPageForward() -> Bool {
    (currentPage == totalPages) ? false : true
  }

  func canPageBackward() -> Bool {
    (currentPage == 1) ? false : true
  }

  func pageFoward() {
    if !canPageForward() { return }
    currentPage = currentPage + 1
    UIscrollToPage(currentPage)
  }

  func pageBackward() {
    if !canPageBackward() { return }
    currentPage = currentPage - 1
    UIscrollToPage(currentPage)
  }

  func save() {
    for page in pages { page.save() }
  }
}
