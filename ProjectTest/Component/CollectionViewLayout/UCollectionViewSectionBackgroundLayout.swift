//
//  UCollectionViewSectionBackgroundLayout.swift
//  ProjectTest
//
//  Created by nor on 2020/8/10.
//  Copyright © 2020 nor. All rights reserved.
//

import UIKit

private let SectionBackground = "UCollectionReusableView"

protocol UCollectionViewSectionBackgroundLayoutDelegateLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        backgroudColorForSectionAt section: Int) -> UIColor
}



class UCollectionViewSectionBackgroundLayout: UICollectionViewFlowLayout {

    private var decorationViewAttrs: [UICollectionViewLayoutAttributes] = []

    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.register(UICollectionReusableView.classForCoder(), forDecorationViewOfKind: SectionBackground)
    }

    override func prepare() {
        super.prepare()
        guard let numberOfSections = self.collectionView?.numberOfSections,
            let delegate = self.collectionView?.delegate as? UCollectionViewSectionBackgroundLayoutDelegateLayout else {
            return
        }

        self.decorationViewAttrs.removeAll()
        for section in 0..<numberOfSections {
            let indexPath = IndexPath(item: 0, section: section)

            guard let numberOfItems = collectionView?.numberOfItems(inSection: section),
            numberOfSections > 0,
            let firstItem = layoutAttributesForItem(at: indexPath),
                let lastItem = layoutAttributesForItem(at: IndexPath(item: numberOfSections - 1, section: section)) else {
                    continue
            }

            var inset = self.sectionInset
            if 
        }
    }
}
