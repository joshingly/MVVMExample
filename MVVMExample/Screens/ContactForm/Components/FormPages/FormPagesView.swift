//
//  FormPagesView.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class FormPagesView: UIScrollView, UIScrollViewDelegate {
  let pageOne = UIStoryboard(name: "FormPageOne", bundle: Bundle.main)
    .instantiateInitialViewController() as! FormPageOneViewController
  let pageTwo = UIStoryboard(name: "FormPageTwo", bundle: Bundle.main)
    .instantiateInitialViewController() as! FormPageTwoViewController

  var currentPage = 1
  var totalPages = 2
  var isScrolling = false

  func setup() {
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    isScrollEnabled = false
    isPagingEnabled = false
    delegate = self

    addSubview(pageOne.view)
    addSubview(pageTwo.view)
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

    pageOne.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    pageTwo.view.frame = CGRect(x: width, y: 0, width: width, height: height)

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
}
