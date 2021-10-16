//
//  PreferencesWithUserDefaultsSwiftUI.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-27.
//

import SwiftUI
import UIKit

class PreferencesWithUserDefaultsSwiftUI: UIHostingController<PreferencesWithUserDefaults> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: PreferencesWithUserDefaults())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
