//
//  SignUpPageSwiftUI.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-16.
//

import SwiftUI

class SignUpPageSwiftUI: UIHostingController<SignUpPageRapsodo> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SignUpPageRapsodo())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
