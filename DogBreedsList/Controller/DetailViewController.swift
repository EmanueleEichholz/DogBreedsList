//
//  DetailViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import SafariServices
import Kingfisher
import CoreData

class DetailViewController: UIViewController {
    
    //MARK: Criando a tabela de detalhes
    lazy var detailTable: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .mWhite()
        
        return table
    }()
    
    //MARK: Declaração de variáveis
    var touchedDog: Dog = Dog()
    let reuseIdentifier = "cell"
    var favorite : Bool = false
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super .viewDidLoad()
        self.view.addSubview(detailTable)
        self.title = touchedDog.name
        self.view.backgroundColor = UIColor.mWhite()
        fetchFavorites()
        if !favorite {
            self.createRightBarButton()
        }
    }
    //MARK: Cria o botão de coração no canto superior direito
    func createRightBarButton() {
        let heartImage = UIImage(systemName: "heart.fill")
        let rightButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavorites))
        rightButton.tintColor = UIColor.mDarkBlue()
        self.navigationItem.rightBarButtonItem = rightButton
    }

    //MARK: Atribui a função do botão de coração
    @objc func getFavorites(){
        let list = FavoriteViewController()
        self.show(list, sender: nil)
    }
}

//MARK: MÉTODOS DE DATA SOURCE
extension DetailViewController: UITableViewDataSource {
    
    //Define o número de linhas da tabela de detalhes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    //Formata as células que compõem a tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.textLabel?.textColor = UIColor.mDarkBlue()
        
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.detailTextLabel?.textColor = UIColor.mPink()

        
        if indexPath.row < 7 {
                cell.detailTextLabel?.text = "Unknow"
            }
        
        
        //Define o conteúdo para cada célula
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Breed Name: "
            guard let name = touchedDog.name else { return cell }
            cell.detailTextLabel?.text = name
        case 1:
            cell.textLabel?.text = "Breed Group: "
            guard let breed_group = touchedDog.breed_group else { return cell }
            cell.detailTextLabel?.text = breed_group
        case 2:
            cell.textLabel?.text = "Bred For:"
            guard let bred_for = touchedDog.bred_for else { return cell }
            cell.detailTextLabel?.text = bred_for
        case 3:
            cell.textLabel?.text = "Life Span:"
            guard let life_span = touchedDog.life_span else { return cell }
            cell.detailTextLabel?.text = life_span
        case 4:
            cell.textLabel?.text = "Height (cm):"
            guard let height = touchedDog.height?.metric else { return cell }
            cell.detailTextLabel?.text = height
        case 5:
            cell.textLabel?.text = "Weight (kg):"
            guard let weight = touchedDog.weight?.metric else { return cell }
            cell.detailTextLabel?.text = weight
        case 6:
            guard let temperament = touchedDog.temperament else { return cell }
            cell.textLabel?.text = "Temperament: "
            cell.detailTextLabel?.text = temperament
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16.0)
            cell.detailTextLabel?.numberOfLines = 0
        case 7:
            return self.showFavoritesButton()
        case 8:
            let cellImage = ImageDetailViewCell()
            if let urlString = touchedDog.image?.url {
                guard let url = URL(string: urlString) else { return cellImage }
                print(url)
                cellImage.setImage(url: url)
                //print(urlString)
            } else {
                cellImage.imageBreed.image = UIImage(named: "dogplaceholder")
            }
            return cellImage
//            guard let urlString = touchedDog.image?.url else { return UITableViewCell() }
//            guard let url = URL(string: urlString) else { return UITableViewCell() }
//            cellImage.setImage(url: url)
//            self.view.backgroundColor = .mWhite()
//            return cellImage
        default:
            return UITableViewCell()
        }
        return cell
    }

    //Define as funções que o botão da célula terá
    func showFavoritesButton() -> UITableViewCell {
            if favorite {
                return self.cellRemoveFromFavorites()
            } else {
                return self.cellAddToFavorites()
            }
    }
    
    //Configura a aparência do botão quando o cachorro ainda não estiver adicionado a lista de favoritos
    func cellAddToFavorites() -> UITableViewCell {
       let cell = BreedTableViewCell()
        cell.textLabel?.textColor = UIColor.mPink()
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(systemName: "star.fill")
        cell.imageView?.tintColor = UIColor.mPink()
        cell.textLabel?.text = "Add this dog to favorites"
        return cell
    }

    //Configura a aparência do botão quando o cachorro já está na lista de favoritos
    func cellRemoveFromFavorites() -> UITableViewCell {
        let cell = BreedTableViewCell()
        cell.textLabel?.textColor = UIColor.mLightBlue()
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(systemName: "trash.fill")
        cell.imageView?.tintColor = UIColor.mLightBlue()
        cell.textLabel?.text = "Remove this dog from favorites"
        return cell
        }
}


//MARK: Métodos de Delegate
extension DetailViewController: UITableViewDelegate {
    
    //Define os métodos que serão chamados quando células específicas forem tocadas
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Adiciona ou remove dos favoritos
        if indexPath.row == 7 {
            if favorite {
                removeFromFavorites()
                favorite = false
            } else {
                addToFavorites()
                favorite = true
            }
        }
        
        //Abre a Imagem no Safari
        if indexPath.row == 8 {
            guard let imageString = touchedDog.image?.url else { return }
            guard let url = URL(string: imageString) else { return }
            let safariVC = SFSafariViewController(url: url)
            self.showDetailViewController(safariVC, sender: nil)
        }
    }
    
    ///Busca os cachorros
    func fetchFavorites() {
            let context = DataBaseController.persistentContainer.viewContext
            do {
                guard let name = touchedDog.name else { return }
                let fetchRequest = DataDog.fetchRequest()
                let predicate = NSPredicate(format: "name == %@", name)
                fetchRequest.predicate = predicate
                let favoriteDog = try context.fetch(fetchRequest)
                if favoriteDog.count > 0 {
                    favorite = true
                } else {
                    favorite = false
                }
            } catch {
                print("Couldn't get the dogs :(")
            }
        }
    
    ///Adiciona o cachorro selecionado no CoreData
    func addToFavorites() {
        if let name = touchedDog.name,
            let breed_group = touchedDog.breed_group,
            let bred_for = touchedDog.bred_for,
            let life_span = touchedDog.life_span,
            let height = touchedDog.height?.metric,
            let weight = touchedDog.weight?.metric,
            let temperament = touchedDog.temperament,
            let image = touchedDog.image?.url {
                
            let context = DataBaseController.persistentContainer.viewContext
                
            let dog = DataDog(context: context)
                
            dog.name = name
            dog.breed_group = breed_group
            dog.bred_for = bred_for
            dog.life_span = life_span
            dog.height = height
            dog.weight = weight
            dog.temperament = temperament
            dog.image = image
//            print("salvando nos favss: \(dog.image)")
            DataBaseController.saveContext()
            favorite = true
            self.detailTable.reloadData()
            }
                
        }
        
    ///Remove o cachorro selecionado do CoreData
        func removeFromFavorites() {
            guard let name = touchedDog.name else { return }
            let fetchRequest = DataDog.fetchRequest()
            let predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.predicate = predicate
            fetchRequest.includesPropertyValues = false
            let context = DataBaseController.persistentContainer.viewContext
            if let objects = try? context.fetch(fetchRequest) {
                for object in objects {
                    context.delete(object)
                }
            }
            try? context.save()
            favorite = false
            self.detailTable.reloadData()
        }
}
