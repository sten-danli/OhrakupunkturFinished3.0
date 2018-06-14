import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  
  var detailViewController: DetailViewController? = nil
  var indication = [Indications]()
  var filteredCandies = [Indications]()
  var section1=[Section1Index]()
  let searchController = UISearchController(searchResultsController: nil)
    
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
    tableView.contentInsetAdjustmentBehavior = .never
    self.navigationController?.navigationBar.isTranslucent = true
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Suchen Sie nach Indikationen"
    searchController.searchBar.barTintColor=UIColor.black
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.delegate = self
    tableView.tableHeaderView = searchFooter
    
    
    searchController.searchBar.scopeButtonTitles = ["All", "Magendarmbeschwerden", "Mund- und Rachenraum", "Other"]
    
    section1 = [
        Section1Index(name: "Was ist Ohrakupunktur", forDetaiTextLabelInSection1: "Geschätzte Lesezeit von Artikeln: 5 Minuten ", forVideo: "", beschreibung: "Ohrakupunktur ist ..."),
        Section1Index(name: "Wie mach ich das", forDetaiTextLabelInSection1: "Geschätzte Lesezeit von Artikeln: 6 Minuten ", forVideo: "", beschreibung: "So machen Sie das ..."),
        Section1Index(name: "Was brauch ich", forDetaiTextLabelInSection1: "Geschätzte Lesezeit von Artikeln: 3 Minuten ", forVideo: "", beschreibung: "Das brauchen Sie ...")

    ]
    
    indication = [
        Indications(category: "Magendarmbeschwerden", name: "Bauchschmerzen", numOfPoint: "6", indication: "Kopfschmerzen", beschreibung: "Die akute Bronchitis ist eine akute, in der Regel infektionsbedingte Entzündung der Atemwege, welche sich im Bereich der Bronchien abspielt. Bei Mitbeteiligung der Luftröhre (Trachea) spricht man von einer Tracheobronchitis.KopfschmerzenDie akute Bronchitis ist eine akute, in der Regel infektionsbedingte Entzündung der Atemwege, welche sich im Bereich der Bronchien abspielt. Bei Mitbeteiligung der Luftröhre (Trachea) spricht man von einer Tracheobronchitis.KopfschmerzenDie akute Bronchitis ist eine akute, in der Regel infektionsbedingte Entzündung der Atemwege, welche sich im Bereich der Bronchien abspielt. Bei Mitbeteiligung der Luftröhre (Trachea) spricht man von einer Tracheobronchitis.KopfschmerzenDie akute Bronchitis ist eine akute, in der Regel infektionsbedingte Entzündung der Atemwege, welche sich im Bereich der Bronchien abspielt. Bei Mitbeteiligung der Luftröhre (Trachea) spricht man von einer Tracheobronchitis.Kopfschmerzen"),
        
        Indications(category: "Endokrine", name: "Alkoholkonsum", numOfPoint: "6", indication: "Kopfschmerzen", beschreibung: "Die akute Bronchitis ist eine akute, in der Regel infektionsbedingte Entzündung der Atemwege, welche sich im Bereich der Bronchien abspielt. Bei Mitbeteiligung der Luftröhre (Trachea) spricht man von einer Tracheobronchitis.."),
      ]
    
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
  }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
  
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
           return "Kurzeinführungen"
        }else{
            return "Indikationen"
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.candyGreen
        }
    }
    
  override func viewWillAppear(_ animated: Bool) {
    if splitViewController!.isCollapsed {
      if let selectionIndexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: selectionIndexPath, animated: animated)
      }
    }
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0{
        return section1.count
    }else if isFiltering() {
      searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: indication.count)
      return filteredCandies.count
    }
    searchFooter.setNotFiltering()
    return indication.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellID=["Cell2","Cell"][indexPath.section]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    let candy: Indications
    if indexPath.section==0{
        cell.textLabel?.text=section1[indexPath.row].name
        cell.detailTextLabel?.text=section1[indexPath.row].forDetaiTextLabelInSection1
        return cell
    }else if isFiltering(){
        candy = filteredCandies[indexPath.row]
    } else {
      candy = indication[indexPath.row]
    }
    cell.textLabel!.text = candy.name
    cell.detailTextLabel!.text = candy.category
        return cell
  }
  

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail"{
      if let indexPath = tableView.indexPathForSelectedRow {
        let candy: Indications
        if isFiltering() {
          candy = filteredCandies[indexPath.row]
        } else {
          candy = indication[indexPath.row]
        }
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailIndications = candy
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }else if segue.identifier=="section2segue"{
        let s2v = (segue.destination as! UINavigationController).topViewController as! Section2ViewController
//            let section1IndexName = sender as! UITableViewCell
        if let indexPath = tableView.indexPathForSelectedRow{
            let oksection=section1[indexPath.row]
        
//        print(section1IndexName.textLabel?.text)
            s2v.detailSection1Index = oksection //your sender is a UITableViewCell
            }
        }
    }

  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredCandies = indication.filter({( candy : Indications) -> Bool in
      let doesCategoryMatch = (scope == "All") || (candy.category == scope)
      
      if searchBarIsEmpty() {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
      }
    })
    tableView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
  }
}
extension MasterViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
