//
//  ExploreController.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 14/12/25.
//

import UIKit

class ExploreController: UIViewController{
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

    }
 
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "Explore"
        
    }
}


