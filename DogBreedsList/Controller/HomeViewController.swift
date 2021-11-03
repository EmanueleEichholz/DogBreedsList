//
//  HomeViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var api: API?
    
    convenience init(api: API) {
        self.init()
        self.api = api
    }
    
    //MARK: Creating Title
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "DOG LIST"
//        label.font = UIFont(name: "DIN Condensed", size: 64)
//        label.textColor = UIColor.white
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    private lazy var titleLabel: UIImageView = {
        let imageDog = "2.png"
        let image = UIImage(named: imageDog)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    
    //MARK: Creating Button to enter the list of all breeds
    private lazy var fullListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Breeds Full List", for: .normal)
        button.backgroundColor = UIColor.mWhite()
        button.titleLabel?.font =  UIFont(name: "DIN Condensed", size: 30)
        button.layer.cornerRadius = 25.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mDarkBlue(), for: .normal)
        button.addTarget(self, action: #selector(buttonFullList), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Creating Button to enter the favorites list
    private lazy var favoritesListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorites Breeds List", for: .normal)
        button.backgroundColor = UIColor.mWhite()
        button.titleLabel?.font =  UIFont(name: "DIN Condensed", size: 30)
        button.layer.cornerRadius = 25.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mDarkBlue(), for: .normal)
        button.addTarget(self, action: #selector(buttonFavoritesList), for: .touchUpInside)
        
        return button
    }()

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraintsTitleLabel()
        constraintsFullListButton()
        constraintsFavoritesListButton()
        view.backgroundColor = UIColor.mDarkBlue()
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Adding created elements to view
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(fullListButton)
        view.addSubview(favoritesListButton)
    }
    
    
    // MARK: View Elements Constraints
    
    //Title Constraints
    private func constraintsTitleLabel(){
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 200).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: fullListButton.topAnchor, constant: -20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
    
    //Button Breeds Full List Constraints
    private func constraintsFullListButton() {
        fullListButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        fullListButton.bottomAnchor.constraint(equalTo: favoritesListButton.topAnchor, constant: -60.0).isActive = true
        fullListButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        fullListButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    //Button Favorites Breeds Constraints
    private func constraintsFavoritesListButton() {
        favoritesListButton.centerXAnchor.constraint(equalTo: fullListButton.centerXAnchor).isActive = true
        favoritesListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0).isActive = true
        favoritesListButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        favoritesListButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    
    //MARK: Giving Actions for buttons
    
    // Opening the main list with all breeds
    @objc func buttonFullList(sender: UIButton!) {
        if let mApi = api {
            let breeds = BreedsTableViewController(api: mApi)
            self.navigationController?.pushViewController(breeds, animated: true)
        } else {
            let breeds = BreedsTableViewController()
            self.navigationController?.pushViewController(breeds, animated: true)
        }
    }
    
    //Opening favorites list
    @objc func buttonFavoritesList(sender: UIButton!) {
        let favs = FavoriteViewController()
        self.navigationController?.pushViewController(favs, animated: true)
    }
}

