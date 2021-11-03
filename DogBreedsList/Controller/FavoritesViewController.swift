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
    
    //MARK: Declarando as variáveis
    var favoriteDog: [DataDog] = []
    var reuseIdentifier = "cell"
    
    
    //MARK: Criando a tabela
    lazy var favoriteBreedsTable: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        
        return table
        
    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoriteBreedsTable)
        self.view.backgroundColor = UIColor.mWhite()
        self.title = "Favorites"
        let nib = UINib(nibName: "BreedTableViewCell", bundle: nil)
        favoriteBreedsTable.register(nib, forCellReuseIdentifier: reuseIdentifier)
       
        
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFavorites()
    }
    
    // MARK: Recarregar a tabela de favoritos
    func reloadFavorites() {
        do {
            self.favoriteDog = try DataBaseController.persistentContainer.viewContext.fetch(DataDog.fetchRequest())
        } catch {
            print("Couldn't fetch data")
        }
        self.favoriteBreedsTable.reloadData()
    }


}

//MARK: Métodos de Data Source

extension FavoriteViewController: UITableViewDataSource {
    //Define a quantidade de células conforme o número de cachorros no array
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
            cell?.labelDescription.numberOfLines = 3
        
            cell?.imageBreed.layer.cornerRadius = 15.0
            cell?.imageBreed.layer.masksToBounds = true
            cell?.imageBreed.contentMode = .scaleAspectFill
            
            
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
            } else {
                cell?.imageBreed.image = UIImage(named: "dogplaceholder")
            }
            return cell!
        }
}

//MARK: Métodos de Delegate

extension FavoriteViewController: UITableViewDelegate {
    
    //Pega os dados do cachorro tocado do CoreData
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = DetailViewController()
        
        let favDataDog = favoriteDog[indexPath.row]
        
        var savedTouchedDog : Dog = Dog()
        savedTouchedDog.name = favDataDog.name
        savedTouchedDog.breed_group = favDataDog.breed_group
        savedTouchedDog.bred_for = favDataDog.bred_for
        savedTouchedDog.life_span = favDataDog.life_span
        savedTouchedDog.height?.metric = favDataDog.height
        savedTouchedDog.weight?.metric = favDataDog.weight
        savedTouchedDog.temperament = favDataDog.temperament
        guard let image = favDataDog.image else { return }
        savedTouchedDog.image?.url = image
        print(favDataDog.image)
        
        //O cachorro tocado da lista de favoritos é atribuito a mesma variável usada para abrir os cachorros da tabela principal, assim é possível utilizar a mesma DetailView controller para os dois casos
       
        detail.touchedDog = savedTouchedDog
        
        self.navigationController?.pushViewController(detail, animated: true)

    }
}

