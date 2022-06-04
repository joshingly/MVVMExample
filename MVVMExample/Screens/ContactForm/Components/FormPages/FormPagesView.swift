//
//  FormPagesView.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class FormPagesView: UIScrollView, UIScrollViewDelegate {
  let pages: [UIViewController] = [
    UIStoryboard(name: "FormPageOne", bundle: Bundle.main)
      .instantiateInitialViewController() as! FormPageOneViewController,
    UIStoryboard(name: "FormPageTwo", bundle: Bundle.main)
      .instantiateInitialViewController() as! FormPageTwoViewController,
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

    for (index, vc) in pages.enumerated() {
      vc.view.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: height)
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
