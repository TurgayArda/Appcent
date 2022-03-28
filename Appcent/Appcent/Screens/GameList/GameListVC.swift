//
//  GameListVC.swift
//  Appcent
//
//  Created by ArdaSisli on 23.03.2022.
//

import UIKit
import AlamofireImage

class GameListVC: UIViewController {
    
   private  var searchBar: UISearchController = {
       let search = UISearchController()
        return search
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentMode = .scaleAspectFit
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: view.frame.width * 2.6 , height: 0)
        return scroll
    }()
    
   private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var pageConroller: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = UIColor.black
        page.currentPageIndicatorTintColor = UIColor.green
        return page
    }()
    
    private lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.text = GameListConstant.GameListError.errorLabel.rawValue
        return label
    }()
    
    private lazy var image0 = UIImageView()
    private lazy var image1 = UIImageView()
    private lazy var image2 = UIImageView()
    private lazy var provider = GameListProvider()
    private lazy var scrollImage: [UIImageView] = [image0, image1, image2]
    private var gameData: [GameResult] = []
    private var error = String()

     var router: GameListRouterProtocol?
     var presenter: GameListPresenterProtocol?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        presenter?.load()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = true
    }
    
    private func initDelegate() {
        collectionView.register(
            GameListCollectionViewCell.self,
            forCellWithReuseIdentifier: GameListCollectionViewCell.Identifier.path.rawValue
        )
        searchBar.searchResultsUpdater = self
        scrollView.delegate = self
        provider.delegate = self
        collectionView.delegate = provider
        collectionView.dataSource = provider
        searchBar.searchBar.placeholder =  GameListConstant.GameListSearch.placeholder.rawValue
        configure()
    }
    
   private func configure() {
        view.backgroundColor = .white
        navigationItem.searchController = searchBar
       searchBar.searchBar.sizeToFit()
        view.addSubview(scrollView)
        view.addSubview(pageConroller)
        view.addSubview(collectionView)
        view.addSubview(errorLabel)
        makeScroll()
        makePage()
        makeCollection()
    }
    
    private func searchTextCount(searchText: String, searchData: [GameResult]) {
        if searchText.count > 2 && searchData.isEmpty == false {
            provider.isSearch(to: true)
            provider.searchData(to: searchData)
            pageConroller.isHidden = true
            collectionView.isHidden = false
            searchCollection()
            errorLabel.isHidden = true
       }
        
        if searchText.count < 2 {
            provider.isSearch(to: false)
            scrollView.isHidden = false
            pageConroller.isHidden = false
            collectionView.isHidden = false
            makePage()
            makeScroll()
            makeCollection()
            errorLabel.isHidden = true
        }
        
        if searchText.count > 2 && searchData.isEmpty {
            scrollView.isHidden = true
            pageConroller.isHidden = true
            collectionView.isHidden = true
            errorLabel.isHidden = false
            makeLabel()
        }
    }
    
    private func scrollImage(game: [GameResult]) {
        for i in 0..<scrollImage.count {
        let gamePage = game[i]
            scrollImage[i].frame = CGRect(
                x: scrollView.frame.width * CGFloat(i),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            
            scrollImage[i].af.setImage(withURL: URL(string: gamePage.backgroundImage)!)
        scrollView.addSubview(scrollImage[i])
        }
    }
}

extension GameListVC: GameListViewDelegate {
    func handleOutPut(_ output: GameListPresenterOutPut) {
        switch output {
        case .gameList(let game):
            provider.load(value: game)
            scrollImage(game: game)
            gameData = game
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .error(let error):
            self.error = error
        case .title(let title):
            self.navigationItem.title = title
        }
    }
}

extension GameListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        let searchData = gameData.filter({$0.name.lowercased().contains(searchText.lowercased())})
        searchTextCount(searchText: searchText, searchData: searchData)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GameListVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
               pageConroller.currentPage = Int(pageNumber)
    }
}

extension GameListVC: GameListProviderDelegate {
    func selected(at select: Int) {
        router?.navigate(to: .detail(select))
    }
}

extension GameListVC {
   private func makeScroll() {
        scrollView.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(20)
            make
                .left
                .equalTo(view)
                .offset(25)
            make
                .right
                .equalTo(view)
                .offset(-25)
            make
                .height
                .equalTo(200)
        }
    }
    private func makePage() {
        pageConroller.snp.makeConstraints { make in
            make
                .top
                .equalTo(scrollView.snp.bottom)
                .offset(10)

            make
                .left
                .equalTo(view)
                .offset(20)
            make
                .right
                .equalTo(view)
                .offset(-20)
        }
    }
    private func makeCollection() {
        collectionView.snp.remakeConstraints({ make in
            make
                .top
                .equalTo(pageConroller.snp.bottom)
                .offset(0)
            make
                .left
                .equalTo(view)
                .offset(0)
            make
                .right
                .equalTo(view)
                .offset(0)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
        })
    }
    
    private func searchCollection() {
        collectionView.snp.makeConstraints({ make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
            make
                .left
                .equalTo(view)
                .offset(0)
            make
                .right
                .equalTo(view)
                .offset(0)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
        })
    }
    
    private func makeLabel() {
         errorLabel.snp.remakeConstraints ({ make in
            make
                .centerX
                .equalTo(view.snp.centerX)
            make
                .centerY
                .equalTo(view.snp.centerY)
        })
    }
}
