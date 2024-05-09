//
//  MapViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit

final class MapViewController: UIViewController {
    private lazy var emptyView: UILabel = {
        let emptyView = UILabel()
        emptyView.text = "Empty"
        
        return emptyView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emptyView)
    }
}
