//
//  BreedsListViewController.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import UIKit
import Kingfisher

class BreedsTableViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let context = DataBaseController.persistentContainer.viewContext
    var arrayOfDogs: [Dog] = []
    var filteredDogs: [Dog] = []
    var savedDogs: [Dog] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    let api = API()
    let reusdeIdentifier = "cell"
    var favorites : Bool = false
    
    //MARK: SEARCH BAR
    
    lazy var breedsTable: UITableView = {
        var table = UITableView()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        
        let nib = UINib(nibName: "BreedTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: reusdeIdentifier)
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        self.view.backgroundColor = UIColor.mLightBlue()
        self.title = "Breeds List"
        self.view.addSubview(self.breedsTable)
        self.fillAndRefreshArrayOfDogs()
        self.createRightBarButton()
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar personagens"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fillAndRefreshArrayOfDogs()
        
    }
    
    
    func fillAndRefreshArrayOfDogs() {
        
        if !favorites {
            
            api.getDogs(urlString: api.setDogsURL(), method: .GET, key: "5c904ece-d726-4d83-b209-b46426cfdace") { dogs in
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
        } else {
//            do {
//                self.savedDogs =  try DataBaseController.persistentContainer.viewContext.fetch(DataDog.fetchRequest())
//            } catch {
//                print("Falha ao trazer as informações do banco de dados.")
//            }
            
        }
        self.breedsTable.reloadData()
    }
    
    func createRightBarButton() {

        let heartImage = UIImage(systemName: "heart.fill")
        let rightButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavorites))
        rightButton.tintColor = UIColor.mDarkBlue()
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func getFavorites(){
        let list = BreedsTableViewController()
        list.favorites = true
        self.show(list, sender: nil)
    }
    
    func showAlertToUser(mensagem: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention!", message: mensagem, preferredStyle: .actionSheet)
            
            let buttonTryAgain = UIAlertAction(title: "Tentar novamente", style: .default) { _ in self.fillAndRefreshArrayOfDogs()
            }
                
            let buttonOpenDownloaded = UIAlertAction(title: "Open Downloaded Breeds", style: .default) { _ in
                let list = BreedsTableViewController()
                list.favorites = true
                self.navigationController?.pushViewController(list, animated: true)
            }
            
            let buttonGotIt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
            alert.addAction(buttonTryAgain)
            alert.addAction(buttonOpenDownloaded)
            alert.addAction(buttonGotIt)
            
            self.present(alert, animated: true, completion: nil)
            }
        }
}

extension BreedsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfDogs.count
    }
    
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
    
    
//    func filterContentForSearchText(_ searchText: String,
//                                    dogsName: [Dog]? = nil) {
//        filteredDogs = arrayOfDogs.filter { (arrayOfDogs: Dog ) -> Bool in
//            return (arrayOfDogs.name?.lowercased().contains(searchText.lowercased()))
//        }
//        tableView.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146.0
    }
}
        
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let title = UILabel(frame: CGRect(x: 160.0, y: 40.0, width: 100, height: 30.0))
//        title.text = "List of dogs"
//        title.textColor = UIColor.mWhite()
//        view.addSubview(title)
//        view.backgroundColor = UIColor.mPink()
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "List of Dogs"
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }


extension BreedsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        detail.touchedDog = self.arrayOfDogs[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension BreedsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
