//
//  ViewController.swift
//  UIKitPanGesture
//
//  Created by Olli Toivanen on 23.11.2022.
//

import UIKit

class PageViewController: UIViewController {
    var initialCenter: CGPoint = .zero

    private let elements: [Element]

    init(_ elements: [Element]) {
           self.elements = elements
           super.init(nibName: nil, bundle: nil)
       }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    

    private let pannableView: UIView = {

            // Initialize View
            let view = UIView( frame: CGRect(origin: .zero,
                                            size: CGSize(width: 200.0, height: 200.0)))
            // Configure View
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

    func addElements(){
        for element in elements {
            var img = UIImageView(image: UIImage(data: element.image!))
            img.center = view.center
            img.alpha = 1
            img.frame = CGRect(x: initialCenter.x, y: initialCenter.y, width: 300, height: 400)
            img.isUserInteractionEnabled = true
            view.addSubview(img)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        let elements = view.subviews
        for element in elements{
            print("moi")
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan))

            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch))
            element.addGestureRecognizer(panGestureRecognizer)
            element.addGestureRecognizer(pinchGestureRecognizer )
        }
        // Center Pannable View



        // Initialize Swipe Gesture Recognizer


        // Add Swipe Gesture Recognizer
    }

    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .began:
            print("dragged")

               initialCenter = sender.view!.center
            case .changed:
               let translation = sender.translation(in: view)

            sender.view!.center = CGPoint(x: initialCenter.x + translation.x,
                                             y: initialCenter.y + translation.y)
           default:
               break
           }
    }

    @objc private func didPinch(_ sender: UIPinchGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.scaledBy(
            x: sender.scale,
            y: sender.scale
        )
        sender.scale = 1
    }
}


