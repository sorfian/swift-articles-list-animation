//
//  ArticleTableViewController.swift
//  Articles List Animation
//
//  Created by Sorfian on 25/03/23.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    let articles = [
        Article(title: "Use Background Transfer Service To Download File in Background", image: "imessage-sticker-pack"),
        Article(title: "Face Detection in iOS Using Core Image", image: "face-detection-featured"),
        Article(title: "Building a Speech-to-Text App Using Speech Framework in iOS", image: "speech-kit-featured"),
        Article(title: "Building Your First Web App in Swift Using Vapor", image: "vapor-web-framework"),
        Article(title: "Creating Gradient Colors Using CAGradientLayer", image: "cagradientlayer-demo"),
        Article(title: "A Beginner's Guide to CALayer", image: "calayer-featured")
    ]
    
    lazy var dataSource = configureDataSource()
    lazy var articleShown: [Bool] = Array(repeating: false, count: articles.count)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSnapshot()
        
//        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    // MARK: - Table view data source

    func configureDataSource() -> UITableViewDiffableDataSource<Section, Article> {

        let cellIdentifier = "articleCell"

        let dataSource = UITableViewDiffableDataSource<Section, Article>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, article in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell

                cell.titleLabel.text = article.title
                cell.postImageView.image = UIImage(named: article.image)

                return cell
            }
        )

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.all])
        snapshot.appendItems(articles, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if articleShown[indexPath.row] {
            return
        }
        
//        Fade-in animation
        cell.alpha = 0
        
//        Rotation animation
        let rotationAngleInRadians = 90 * CGFloat(Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        
//        Fly-in animation
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
        
        articleShown[indexPath.row] = true
    }

}
