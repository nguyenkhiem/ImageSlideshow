//
//  PageIndicator.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 27.05.18.
//

import UIKit

/// Cusotm Page Indicator can be used by implementing this protocol
public protocol PageIndicatorView: class {
    /// View of the page indicator
    var view: UIView { get }

    /// Current page of the page indicator
    var page: Int { get set }

    /// Total number of pages of the page indicator
    var numberOfPages: Int { get set}
}

extension UIPageControl: PageIndicatorView {
    public var view: UIView {
        return self
    }

    public var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }

    open override func sizeToFit() {
        var frame = self.frame
        frame.size = size(forNumberOfPages: numberOfPages)
        frame.size.height = 30
        self.frame = frame
    }
}

/// Page indicator that shows page in numeric style, eg. "5/21"
public class LabelPageIndicator: UILabel, PageIndicatorView {
    public var view: UIView {
        return self
    }

    public var totalPages: Int = 0

    public var numberOfPages: Int = 0 {
        didSet {
            updateLabel()
        }
    }

    public var page: Int = 0 {
        didSet {
            updateLabel()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        self.textAlignment = .center
        self.textColor = .white
    }

    private func updateLabel() {
        text = "\(page+1)/\(totalPages)"
    }

    public override func sizeToFit() {
        let maximumString = String(repeating: "8", count: numberOfPages) as NSString
        var size = maximumString.size(withAttributes: [.font: font as Any])
        if size.width < 50 {
            size.width = 50
        }
        
        self.frame.size = size
    }
}
