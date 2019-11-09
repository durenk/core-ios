//
//  PreviewFile.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 08/11/19.
//

import UIKit

open class PreviewFile: NSObject, UIDocumentInteractionControllerDelegate {
    private var controller: UIViewController!

    public init(controller: UIViewController) {
        super.init()
        self.controller = controller
    }

    public func previewFile(path: URL)  {
        let documentInteractionController = UIDocumentInteractionController(url: path)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    }

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.controller
    }
}
