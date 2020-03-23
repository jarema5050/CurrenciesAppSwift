//
//  SpinnerViewController.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 21/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        spinner.color = AppColors.lightGreen
        spinner.transform = CGAffineTransform(scaleX: 1.75, y: 1.75);
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
