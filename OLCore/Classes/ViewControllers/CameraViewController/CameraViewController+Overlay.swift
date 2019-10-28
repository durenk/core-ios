//
//  CameraViewController+Overlay.swift
//  OLCore
//
//  Created by DENZA on 28/10/19.
//

import Foundation

extension CameraViewController {
    public func addOverlayIso7810Id1(
        horizontalPadding: CGFloat,
        overlayColor: UIColor = UIColor.black,
        overlayAlpha: CGFloat = 0.4
    ) {
        let width = SizeHelper.getWidth(
            containerWidth: view.bounds.size.width,
            horizontalPadding: horizontalPadding
        )
        let height = SizeHelper.getHeightOfScale(
            width: width,
            realWidth: IsoSize7810.Id1.width,
            realHeight: IsoSize7810.Id1.height
        )
        let originX = SizeHelper.getOriginXAlignCenter(
            width: width,
            containerWidth: view.bounds.size.width
        )
        let originY = SizeHelper.getOriginYAlignCenter(
            height: height,
            containerHeight: view.bounds.size.height
        )
        print("===width:", width)
        print("===height:", height)
        print("===originX:", originX)
        print("===originY:", originY)
    }
}
