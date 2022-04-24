import UIKit
import PinLayout

/// Контроллер для экрана афиши
final class PosterViewController: UIViewController {
    /// Вывод информации из контроллера
    private let output: PosterViewOutput
    /// Таблица событий
    private let tableView = UITableView()
    /// Поисковая строка
    private let searchController = UISearchController(searchResultsController: nil)
    /// Поисковая строка пустая или нет
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    /// Применен фильтр или нет
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    /// Инициализация
    init(output: PosterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Афиша"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        
        tableView.register(EntertaimentTableViewCell.self, forCellReuseIdentifier: "EntertaimentTableViewCell")

        searchController.searchResultsUpdater = self
        // взаимодействие с отфильтрованным
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        //отпустить строку поиска при переходе на другой экран
        definesPresentationContext = true
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "slider.horizontal.3"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapFilter))
        output.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }

    /// Обновить таблицу
    @objc
    private func didPullRefresh() {
        output.didPullRefresh()
    }

    /// Применить фильтры к таблице
    @objc
    private func didTapFilter() {
        output.didTapFilter()
    }
}

/// Работа с таблицей
extension PosterViewController: UITableViewDataSource, UITableViewDelegate {
    /// Количество секций таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return output.searchPostersViewModels.count
        }
        return output.postersViewModels.count
    }

    /// Выд ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntertaimentTableViewCell", for: indexPath) as? EntertaimentTableViewCell else {
            return .init()
            }

        cell.layer.cornerRadius = 10
        
        if isFiltering {
            cell.configure(with: output.searchPostersViewModels[indexPath.row])
        } else {
            cell.configure(with: output.postersViewModels[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }

    /// Установить высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }

    /// Обработка нажатия на строку в таблице
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering{
            output.didTapCell(poster: output.searchPostersViewModels[indexPath.row])
        } else {
            output.didTapCell(poster: output.postersViewModels[indexPath.row])
        }
    }
}

/// Получение данных от нажатий пользователя
extension PosterViewController: PosterViewInput {
    /// Загрузить заново данные в таблице
    func reloadData() {
        self.tableView.refreshControl?.endRefreshing()
        navigationItem.searchController = searchController
        self.tableView.reloadData()
    }

    /// Начать загрузку
    func startRefreshing() {
        self.tableView.refreshControl?.beginRefreshing()
    }
}

/// Работа с поисковой строкой
extension PosterViewController: UISearchResultsUpdating{
    /// Обновить результаты поиска
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchController.searchBar.text ?? "")
    }

    /// Отфильтровать события в соответствии с поиском
    private func filterContentForSearch(_ searchText: String) {
        output.searchPostersViewModels = output.postersViewModels.filter({ (poster: PosterViewModel) -> Bool in
            (poster.short_title.lowercased().contains(searchText.lowercased()) || poster.title.lowercased().contains(searchText.lowercased()))
        })
        tableView.reloadData()
    }
}
