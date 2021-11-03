//
//  FavoritesViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 02/11/21.
//

import UIKit

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    var favoriteDog: [DataDog] = []
    var reuseIdentifier = "cell"
    
    
    //MARK: Criando a tabela
    lazy var favoriteBreedsTable: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        
        let nib = UINib(nibName: "BreedTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: reuseIdentifier)
        
        return table
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoriteBreedsTable)
        self.view.backgroundColor = UIColor.mWhite()
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableViewAddFavorites()
    }
    
    // MARK: Métodos
    func reloadTableViewAddFavorites() {
        do {
            self.favoriteDog = try DataBaseController.persistentContainer.viewContext.fetch(DataDog.fetchRequest())
        } catch {
            print("Não consegui trazer informações do banco de dados!")
        }
        self.favoriteBreedsTable.reloadData()
    }

}

//MARK: Extensões

extension FavoriteViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteDog.count
    }
    
    //Define a altura da célula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146.0
    }

    //Configura as células dentro da tabela
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? BreedTableViewCell
            
            let favDog = favoriteDog[indexPath.row]
        
            cell?.accessoryType = .disclosureIndicator
            
            cell?.labelTitle.text = favDog.name
            cell?.labelTitle.numberOfLines = 2
            cell?.labelDescription.text = favDog.temperament
            cell?.labelDescription.adjustsFontSizeToFitWidth = false
        
            cell?.imageBreed.contentMode = .scaleAspectFill
            cell?.imageBreed.layer.cornerRadius = 20.0
            cell?.labelDescription.numberOfLines = 3
            cell?.backgroundColor = UIColor.mWhite()
            
            //Configura a imagem
        if let image = favDog.image {
                let url = URL(string: image)
                cell?.imageBreed.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "dogplaceholder"),
                    options: [ .transition(ImageTransition.fade(2.0))],
                    progressBlock: nil,
                    completionHandler: nil)
            }
            return cell!
        }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = DetailViewController()
        
        let favDataDog = favoriteDog[indexPath.row]
        

        var imageDog = DogImage()
        imageDog.url = favDataDog.image
        
        var savedTouchedDog : Dog = Dog()
        savedTouchedDog.name = favDataDog.name
        savedTouchedDog.breed_group = favDataDog.breed_group
        savedTouchedDog.bred_for = favDataDog.bred_for
        savedTouchedDog.life_span = favDataDog.life_span
        savedTouchedDog.height?.metric = favDataDog.height
        savedTouchedDog.weight?.metric = favDataDog.weight
        savedTouchedDog.temperament = favDataDog.temperament
        savedTouchedDog.image?.url = favDataDog.image
        
        detail.touchedDog = savedTouchedDog
        
        self.navigationController?.pushViewController(detail, animated: true)

    }
}

