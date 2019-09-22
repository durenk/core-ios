//
//  SizeHelper.swift
//  OLCore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public class SizeHelper {
    public static var BaseScreenWidth: CGFloat = 320
    public static var ScreenWidth: CGFloat = 0.0
    public static var ScreenHeight: CGFloat = 0.0
    public static var WindowOffsetTop: CGFloat = 0.0
    public static var WindowOffsetBottom: CGFloat = 0.0
    public static var WindowWidth: CGFloat = 0.0
    public static var WindowHeight: CGFloat = 0.0

    public static func calculateScreenSize() {
        ScreenWidth = UIScreen.main.bounds.width
        ScreenHeight = UIScreen.main.bounds.height
    }

    public static func calculateWindowSize(
        navigationController: UINavigationController?,
        tabBarController: UITabBarController?
    ) {
        WindowOffsetTop = UIApplication.shared.statusBarFrame.size.height
        if navigationController != nil {
            WindowOffsetTop = WindowOffsetTop
                + navigationController!.navigationBar.frame.size.height
        }
        WindowOffsetBottom = 0
        if tabBarController != nil && tabBarController!.tabBarIsVisible() {
            WindowOffsetBottom = tabBarController!.tabBar.frame.size.height
        }
        WindowWidth = UIScreen.main.bounds.size.width
        WindowHeight = UIScreen.main.bounds.height - WindowOffsetTop - WindowOffsetBottom
    }

    public static func getActualSize(size: CGFloat) -> CGFloat {
        return size / BaseScreenWidth * ScreenWidth
    }

    public static func getHeight(containerHeight: CGFloat, verticalPadding: CGFloat) -> CGFloat {
        let height: CGFloat = containerHeight - (verticalPadding * 2)
        return height
    }

    public static func getHeightOfContainer(lastFrame: CGRect, paddingBottom: CGFloat) -> CGFloat {
        let height: CGFloat = lastFrame.origin.y + lastFrame.size.height + paddingBottom
        return height
    }

    public static func getWidth(containerWidth: CGFloat, horizontalPadding: CGFloat) -> CGFloat {
        let width: CGFloat = containerWidth - (horizontalPadding * 2)
        return width
    }

    public static func getWidthGrid(
        containerWidth: CGFloat,
        horizontalPadding: CGFloat,
        columnSpacing: CGFloat,
        columnCount: NSInteger
    ) -> CGFloat {
        let spaceWidth: CGFloat = SizeHelper.getWidth(
            containerWidth: containerWidth,
            horizontalPadding: horizontalPadding
        )
        let totalColumnSpacing: CGFloat = CGFloat(columnCount - 1) * columnSpacing
        let width: CGFloat = (spaceWidth - totalColumnSpacing) / CGFloat(columnCount)
        return width
    }

    public static func getWidthOfScale(height: CGFloat, realWidth: CGFloat, realHeight: CGFloat) -> CGFloat {
        let width: CGFloat = realWidth / realHeight * height
        return width
    }

    public static func getHeightOfScale(width: CGFloat, realWidth: CGFloat, realHeight: CGFloat) -> CGFloat {
        let height: CGFloat = realHeight / realWidth * width
        return height
    }

    public static func getOriginXAlignCenter(width: CGFloat, containerWidth: CGFloat) -> CGFloat {
        let originX: CGFloat = (containerWidth - width) / 2
        return originX
    }

    public static func getOriginXAlignRight(width: CGFloat, containerWidth: CGFloat, marginRight: CGFloat) -> CGFloat {
        let originX: CGFloat = containerWidth - width - marginRight
        return originX
    }

    public static func getOriginYAlignCenter(height: CGFloat, containerHeight: CGFloat) -> CGFloat {
        let originY: CGFloat = (containerHeight - height) / 2
        return originY
    }

    public static func getOriginYAlignBottom(
        height: CGFloat,
        containerHeight: CGFloat,
        marginBottom: CGFloat
    ) -> CGFloat {
        let originY: CGFloat = containerHeight - height - marginBottom
        return originY
    }

    public static func getOriginXAfterFrame(frame: CGRect, horizontalMargin: CGFloat) -> CGFloat {
        let originX: CGFloat = frame.origin.x + frame.size.width + horizontalMargin
        return originX
    }

    public static func getOriginYAfterFrame(frame: CGRect, verticalMargin: CGFloat) -> CGFloat {
        let originY: CGFloat = frame.origin.y + frame.size.height + verticalMargin
        return originY
    }

    public static func getOffsetBottom(frame: CGRect) -> CGFloat {
        return frame.origin.y + frame.size.height
    }

    public static func getOriginYBeforeFrame(frame: CGRect, beforeFrame: CGRect, verticalMargin: CGFloat) -> CGFloat {
        let originY: CGFloat = beforeFrame.origin.y - frame.size.height - verticalMargin
        return originY
    }

    public static func getPercentValue(percent: CGFloat, valueOf: CGFloat) -> CGFloat {
        return percent / 100.0 * valueOf
    }

}
