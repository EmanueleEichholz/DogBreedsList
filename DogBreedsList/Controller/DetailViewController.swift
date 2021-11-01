//
//  DetailViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import SafariServices
import Kingfisher

class DetailViewController: UIViewController {
    
    var touchedDog: Dog = Dog()
    let reuseIdentifier = "cell"
    
    lazy var uitv_Tabela: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        return table
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.view.addSubview(self.uitv_Tabela)
        self.title = touchedDog.name
        self.view.backgroundColor = UIColor.mWhite()
        self.getUserDefaults()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.mLightBlue()
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.detailTextLabel?.textColor = UIColor.mPink()
        cell.backgroundColor = .clear
        
        if indexPath.row < 7 {
                cell.detailTextLabel?.text = "Unknow"
            }
        
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
            cell.textLabel?.text = "Tap here to add to favorites"
            cell.accessoryType = .detailButton
            cell.selectionStyle = .gray
            //quero fazer botao on/off
        case 8:
            let cellImage = ImageViewCell()
            guard let urlString = touchedDog.image?.url else { return UITableViewCell() }
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            cellImage.setImage(url: url)
            return cellImage
        default:
            return UITableViewCell()
        }
        return cell
    }
}


extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 7 {
            guard let name = touchedDog.name else { return }
            self.saveUserDefaults(nome: name)
        }
            
            //salvar no userdefaults = [elefante]
            //dicionario (key, value) = (elefantes, [Elefante])
            //criar uma viewcontroller para mostrar os favoritados
            //criar a exclusao de um elefante favoritado

        if indexPath.row == 8 {
            guard let imageString = touchedDog.image?.url else { return }
            guard let url = URL(string: imageString) else { return }
            let safariVC = SFSafariViewController(url: url)
            self.showDetailViewController(safariVC, sender: nil)
        }
        
    }

}