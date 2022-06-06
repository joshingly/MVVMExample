//
//  ContactFormPagesView.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormPagesView: UIScrollView, UIScrollViewDelegate {
  let pages: [ContactFormPageViewController] = [
    UIStoryboard(name: "ContactFormPageOne", bundle: Bundle.main)
      .instantiateInitialViewController() as! ContactFormPageOneViewController,
    UIStoryboard(name: "ContactFormPageTwo", bundle: Bundle.main)
      .instantiateInitialViewController() as! ContactFormPageTwoViewController,
  ]

  var isScrolling = false
  weak var viewController: ContactFormViewController! { didSet {
    contactForm.UIscrollToPage = { [unowned self] page in
      self.scrollTo(page: page)
    }

    setNeedsLayout()
  } }
  var contactForm: ContactFormViewModel { viewController.contactForm }

  func setup() {
    isScrollEnabled = false
    isPagingEnabled = false
    delegate = self

    for page in pages { addSubview(page.view) }
    setNeedsLayout()
  }

  private func scrollTo(page: Int, animated: Bool = true) {
    let width = bounds.width
    let point = CGPoint(x: Int(width) * (page - 1), y: 0)
    if animated { isScrolling = true }
    setContentOffset(point, animated: animated)
  }

  func nextPage() {
    if isScrolling { return }
    contactForm.pageFoward()
  }

  func previousPage() {
    if isScrolling { return }
    contactForm.pageBackward()
  }

  func sizePages() {
    if isScrolling { return }

    let width = bounds.width
    let height = bounds.height

    for (index, page) in pages.enumerated() {
      page.view.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: height)
    }

    contentSize = CGSize(
      width: width * CGFloat(2),
      height: height
    )

    scrollTo(page: contactForm.currentPage, animated: false)
  }

  func scrollViewDidEndScrollingAnimation(_: UIScrollView) {
    isScrolling = false
    sizePages()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    sizePages()
  }
}
