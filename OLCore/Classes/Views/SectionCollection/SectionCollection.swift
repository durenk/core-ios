//
//  SectionCollection.swift
//  OLCore
//
//  Created by DENZA on 04/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

private struct EmptySize {
    static let Small = CGFloat(20)
    static let Medium = CGFloat(30)
    static let Large = CGFloat(40)
}

open class SectionCollection {
    private var contentView: TableView = TableView()
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
