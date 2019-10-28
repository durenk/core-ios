//
//  CameraViewController+Overlay.swift
//  OLCore
//
//  Created by DENZA on 28/10/19.
//

import UIKit

extension CameraViewController {
    public func addOverlayIso7810Id1(
        horizontalPadding: CGFloat,
        overlayColor: UIColor = UIColor.black,
        overlayAlpha: CGFloat = 0.4
    ) {
        let width = SizeHelper.getWidth(
            containerWidth: contentView.bounds.size.width,
            horizontalPadding: horizontalPadding
        )
        let height = SizeHelper.getHeightOfScale(
            width: width,
            realWidth: IsoSize7810.Id1.width,
            realHeight: IsoSize7810.Id1.height
        )
        let originX = SizeHelper.getOriginXAlignCenter(
            width: width,
            containerWidth: contentView.bounds.size.width
        )
        let originY = SizeHelper.getOriginYAlignCenter(
            height: height,
            containerHeight: contentView.bounds.size.height
        )
        let overlayPath = UIBezierPath(rect: contentView.bounds)
        let transparentPath = UIBezierPath(rect: CGRect(
            x: originX,
            y: originY,
            width: width,
            height: height
        ))
        overlayPath.append(transparentPath)
        overlayPath.usesEvenOddFillRule = true
        let fillLayer = CAShapeLayer(layer: contentView.layer)
        fillLayer.path = overlayPath.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = overlayColor.withAlphaComponent(overlayAlpha).cgColor
        contentView.layer.addSublayer(fillLayer)
    }
}
