//
//  SectionCollection.swift
//  OLCore
//
//  Created by DENZA on 04/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

private struct EmptySize {
    static let XSmall = CGFloat(10)
    static let Small = CGFloat(20)
    static let Medium = CGFloat(30)
    static let Large = CGFloat(40)
    static let XLarge = CGFloat(80)
    static let XXLarge = CGFloat(120)
}

open class SectionCollection {
    private var contentView: TableView = TableView()
    public var emptyXSmall: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.XSmall)
            return section
        }
    }
    public var emptySmall: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.Small)
            return section
        }
    }
    public var emptyMedium: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.Medium)
            return section
        }
    }
    public var emptyLarge: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.Large)
            return section
        }
    }
    public var emptyXLarge: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.XLarge)
            return section
        }
    }
    public var emptyXXLarge: EmptySection {
        get {
            let section = EmptySection()
            section.configure(contentView: contentView, height: EmptySize.XXLarge)
            return section
        }
    }
    public var activityIndicator: ActivityIndicatorSection {
        get {
            let section = ActivityIndicatorSection()
            section.configure(contentView: contentView, style: .gray)
            return section
        }
    }
    public var lightActivityIndicator: ActivityIndicatorSection {
        get {
            let section = ActivityIndicatorSection()
            section.configure(contentView: contentView, style: .white)
            return section
        }
    }

    public func configure(contentView: TableView) {
        self.contentView = contentView
    }
}
