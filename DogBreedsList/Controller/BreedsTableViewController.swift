//
//  BreedsListViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import Kingfisher

class BreedsTableViewController: UIViewController {
    
    //MARK: Declaração de variáveis
    let context = DataBaseController.persistentContainer.viewContext
    var arrayOfDogs: [Dog] = []
    var api: DogAPI?
    var savedDogs: [Dog] = []
    let reusdeIdentifier = "cell"
    var favorites : Bool = false
    let apiKey = "5c904ece-d726-4d83-b209-b46426cfdace"
    
    //MARK: Injeção de dependência dentro da classe
    convenience init(api: DogAPI) {
        self.init()
        self.api = api
    }
    
    //MARK: Criando a tabela
    lazy var breedsTable: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        
        let nib = UINib(nibName: "BreedTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: reusdeIdentifier)
        
        return table
        
    }()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.breedsTable)
        self.fillAndRefreshArrayOfDogs()
        self.view.backgroundColor = UIColor.mWhite()
        if favorites {
            self.title = "Favorites Breeds"
        } else {
            self.title = "Breeds List"
            self.createRightBarButton()
        }
    }
    
    //MARK: Busca os itens na API, popula o arrayOfDogs e atualiza a tabela
    func fillAndRefreshArrayOfDogs() {
        
            guard let mApi = self.api else { return }
            
            mApi.getDogs(urlString: mApi.setDogsURL(), method: .GET, key: apiKey) { dogs in
                DispatchQueue.main.async {
                    self.arrayOfDogs = dogs
                    print("Quantidade de cachorros: \(self.arrayOfDogs.count)")
                    self.breedsTable.reloadData()
                }
                
            } failure: { error in
                switch error {
                case .emptyArray:
                    self.showAlertToUser(mensagem: "Error Loading Data")
                case .notFound:
                    self.showAlertToUser(mensagem: "No Internet Connection")
                default:
                    break;
                }
            }
        
        self.breedsTable.reloadData()
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
        let list = BreedsTableViewController()
        list.favorites = true
        self.show(list, sender: nil)
    }
    
    //MARK: Mostra alerta para o usuário caso ele esteja sem conexão com a internet
    func showAlertToUser(mensagem: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention!", message: mensagem, preferredStyle: .actionSheet)
            
            let buttonTryAgain = UIAlertAction(title: "Try Again", style: .default) { _ in self.fillAndRefreshArrayOfDogs() }
                
            let buttonOpenFavorites = UIAlertAction(title: "Open Favorites Breeds", style: .default) { _ in
                let list = BreedsTableViewController()
                list.favorites = true
                self.navigationController?.pushViewController(list, animated: true) }
            
            let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
            alert.addAction(buttonTryAgain)
            alert.addAction(buttonOpenFavorites)
            alert.addAction(buttonCancel)
            
            self.present(alert, animated: true, completion: nil)
            
            }
        }
}

//MARK: DATA SOURCE
extension BreedsTableViewController: UITableViewDataSource {
    
    //Retorna o número de célula igual ao número de cachorros no array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfDogs.count
    }
    
    //Define a altura da célula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146.0
    }
    
    //Configura as células dentro da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reusdeIdentifier, for: indexPath) as? BreedTableViewCell
        
        cell?.accessoryType = .disclosureIndicator
        
        cell?.labelTitle.text = self.arrayOfDogs[indexPath.row].name
        cell?.labelTitle.numberOfLines = 2
        cell?.labelDescription.text = self.arrayOfDogs[indexPath.row].temperament
        cell?.labelDescription.adjustsFontSizeToFitWidth = false
        cell?.imageBreed.contentMode = .scaleAspectFill
        cell?.imageBreed.layer.cornerRadius = 20.0
        cell?.labelDescription.numberOfLines = 3
        cell?.backgroundColor = UIColor.mWhite()
        
        //Configura a imagem
        if let image = self.arrayOfDogs[indexPath.row].image?.url {
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
   

//MARK: DELEGATE
extension BreedsTableViewController: UITableViewDelegate {
    
    //Abre a tela de detalhes do cachorro selecionado
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let localRepository = LocalRepository()
        let detail = DetailViewController(localRepository: localRepository)
        detail.touchedDog = self.arrayOfDogs[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
