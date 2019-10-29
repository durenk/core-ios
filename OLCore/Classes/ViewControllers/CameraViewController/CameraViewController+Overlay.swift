//
//  CameraViewController+Overlay.swift
//  OLCore
//
//  Created by DENZA on 28/10/19.
//

import UIKit

extension CameraViewController {
    private func getTransparentRect(
        ratio: CGSize,
        horizontalPadding: CGFloat
    ) -> CGRect {
        let width = SizeHelper.getWidth(
            containerWidth: contentView.bounds.size.width,
            horizontalPadding: horizontalPadding
        )
        let height = SizeHelper.getHeightOfScale(
            width: width,
            realWidth: ratio.width,
            realHeight: ratio.height
        )
        let originX = SizeHelper.getOriginXAlignCenter(
            width: width,
            containerWidth: contentView.bounds.size.width
        )
        let originY = SizeHelper.getOriginYAlignCenter(
            height: height,
            containerHeight: contentView.bounds.size.height
        )
        return CGRect(
            x: originX,
            y: originY,
            width: width,
            height: height
        )
    }

    public func addOverlay(
        rectangleRatio: CGSize,
        horizontalPadding: CGFloat,
        overlayColor: UIColor = UIColor.black,
        overlayAlpha: CGFloat = 0.5
    ) {
        let transparentPath = UIBezierPath(rect: getTransparentRect(
            ratio: rectangleRatio,
            horizontalPadding: horizontalPadding)
        )
        let overlayPath = UIBezierPath(rect: contentView.bounds)
        overlayPath.append(transparentPath)
        overlayPath.usesEvenOddFillRule = true
        overlayLayer?.removeFromSuperlayer()
        overlayLayer = CAShapeLayer(layer: contentView.layer)
        guard let overlayLayer = overlayLayer else { return }
        overlayLayer.path = overlayPath.cgPath
        overlayLayer.fillRule = CAShapeLayerFillRule.evenOdd
        overlayLayer.fillColor = overlayColor.withAlphaComponent(overlayAlpha).cgColor
        contentView.layer.addSublayer(overlayLayer)
    }
}
