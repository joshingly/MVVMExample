//
//  ContactFormPagesView.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormPagesView: UIScrollView, UIScrollViewDelegate {
  let pages: [UIViewController] = [
    UIStoryboard(name: "ContactFormPageOne", bundle: Bundle.main)
      .instantiateInitialViewController() as! ContactFormPageOneViewController,
    UIStoryboard(name: "ContactFormPageTwo", bundle: Bundle.main)
      .instantiateInitialViewController() as! ContactFormPageTwoViewController,
  ]

  var currentPage = 1
  var totalPages: Int { pages.count }
  var isScrolling = false

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
    if currentPage == totalPages { return }
    if isScrolling { return }

    currentPage = currentPage + 1
    scrollTo(page: currentPage)
  }

  func previousPage() {
    if currentPage == 1 { return }
    if isScrolling { return }

    currentPage = currentPage - 1
    scrollTo(page: currentPage)
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

    scrollTo(page: currentPage, animated: false)
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
