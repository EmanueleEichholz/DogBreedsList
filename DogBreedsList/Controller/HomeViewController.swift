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
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Creating Button to enter the list of all breeds
    private lazy var fullListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("Breeds Full List", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Creating Button to enter the favorites list
    private lazy var favoritesListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("Favorites Breeds List", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    //MARK: Creating Button to randomize and open a specific breed
    private lazy var randomBreedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("See a Random Breed", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)

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
        view.backgroundColor = UIColor.mLightBlue()
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
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
    }
    
    private func constraintsFullListButton() {
        fullListButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        fullListButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 160).isActive = true
    }
    
    private func constraintsFavoritesListButton() {
        favoritesListButton.centerXAnchor.constraint(equalTo: fullListButton.centerXAnchor).isActive = true
        favoritesListButton.topAnchor.constraint(equalTo: fullListButton.bottomAnchor, constant: 30).isActive = true
    }
    
    private func constraintsRandomBreedButton() {
        randomBreedButton.centerXAnchor.constraint(equalTo: favoritesListButton.centerXAnchor).isActive = true
        randomBreedButton.topAnchor.constraint(equalTo: favoritesListButton.bottomAnchor, constant: 30).isActive = true
    }
    
    
    //MARK: Giving Actions for buttons
    @objc func buttonAction(sender: UIButton!) {

        let breeds = BreedsTableViewController()
        self.show(breeds, sender: nil)
        print("Botao foi clicado")
        
    }
}

