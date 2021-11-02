//
//  HomeViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Creating Title
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "DOG LIST"
        label.font = UIFont(name: "DIN Condensed", size: 64)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    var api: API?
    
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
    
    //MARK: Creating Button to randomize and open a specific breed
    private lazy var randomBreedButton: UIButton = {
        let button = UIButton()
        button.setTitle("See a Random Breed", for: .normal)
        button.backgroundColor = UIColor.mWhite()
        button.titleLabel?.font =  UIFont(name: "DIN Condensed", size: 30)
        button.layer.cornerRadius = 25.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mDarkBlue(), for: .normal)

        return button
    }()

    convenience init(api: API) {
        self.init()
        self.api = api
    }

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraintsTitleLabel()
        constraintsFullListButton()
        constraintsFavoritesListButton()
        view.backgroundColor = UIColor.mDarkBlue()
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Adding created elements to view
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(fullListButton)
        view.addSubview(favoritesListButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK: View Elements Constraints
    private func constraintsTitleLabel(){
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 120).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: fullListButton.topAnchor, constant: 120).isActive = true
    }
    
    private func constraintsFullListButton() {
        fullListButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        fullListButton.bottomAnchor.constraint(equalTo: favoritesListButton.topAnchor, constant: -50.0).isActive = true
        fullListButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        fullListButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    private func constraintsFavoritesListButton() {
        favoritesListButton.centerXAnchor.constraint(equalTo: fullListButton.centerXAnchor).isActive = true
        favoritesListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
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
        print("Botão da lista principal foi clicado")
    }
    
    @objc func buttonFavoritesList(sender: UIButton!) {
        let breeds = BreedsTableViewController()
        breeds.favorites = true
        self.navigationController?.pushViewController(breeds, animated: true)
        print("Botão da lista de favoritos foi clicado")
    }
    
}

