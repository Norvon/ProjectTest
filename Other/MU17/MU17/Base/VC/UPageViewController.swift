//
//  UPageViewController.swift
//  MU17
//
//  Created by nor on 2020/11/12.
//

import UIKit
import HMSegmentedControl

enum UpageStyle {
    case none
    case navgationBarSegment
    case topTabbar
}

class UPageViewController: NORBaseVC {

    var pageStyle: UpageStyle!
    
    lazy var segment: HMSegmentedControl = {
        return HMSegmentedControl().then {
            $0.addTarget(self, action: #selector(changeIndex(segment:)), for: .valueChanged)
        }
    }()
    
    lazy var pageVC: UIPageViewController = {
        return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }()
    
    private(set) var vcs: [UIViewController]!
    private(set) var titles: [String]!
    private var currentSelecIndex: Int = 0
    
    convenience init(titles: [String] = [], vcs: [UIViewController] = [], pageStyle: UpageStyle = .none) {
        self.init()
        self.titles = titles
        self.vcs = vcs
        self.pageStyle = pageStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func changeIndex(segment: UISegmentedControl) {
        let index = segment.selectedSegmentIndex
        if currentSelecIndex != index {
            let target: [UIViewController] = [vcs[index]]
            let direction: UIPageViewController.NavigationDirection = currentSelecIndex > index ? .reverse : .forward
            pageVC.setViewControllers(target, direction: direction, animated: false) { [weak self](finish) in
                self?.currentSelecIndex = index
            }
        }
    }
}
