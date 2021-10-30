//
//  HomeViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit

class HomeViewColtroller: UIViewController {
    
    //MARK: Creating Title
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "DOG LIST"
        label.font = UIFont(name: "DIN Condensed", size: 64)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
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

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraintsTitleLabel()
        constraintsFullListButton()
        constraintsFavoritesListButton()
        constraintsRandomBreedButton()
        view.backgroundColor = UIColor.mDarkBlue()
    }
    
    //MARK: Adding created elements to view
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(fullListButton)
        view.addSubview(favoritesListButton)
        view.addSubview(randomBreedButton)
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
        //favoritesListButton.topAnchor.constraint(equalTo: fullListButton.bottomAnchor, constant: 50).isActive = true
        favoritesListButton.bottomAnchor.constraint(equalTo: randomBreedButton.topAnchor, constant: -50.0).isActive = true
        favoritesListButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        favoritesListButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    private func constraintsRandomBreedButton() {
        randomBreedButton.centerXAnchor.constraint(equalTo: favoritesListButton.centerXAnchor).isActive = true
        //randomBreedButton.topAnchor.constraint(equalTo: favoritesListButton.bottomAnchor, constant: 50).isActive = true
        randomBreedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120.0).isActive = true
        randomBreedButton.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        randomBreedButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    
    //MARK: Giving Actions for buttons
    @objc func buttonAction(sender: UIButton!) {

        let breeds = BreedsTableViewController()
        self.show(breeds, sender: nil)
        print("Botao foi clicado")
        
    }
}

