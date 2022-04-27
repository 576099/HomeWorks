//
//  ProfileViewController.swift
//  UIBaseComponents
//
//  Created by Александр Смирнов on 16.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.autoresizingMask = [.flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var dataSource: [Post] = []
    
    private func addPostsInDataSource() {
        let post1 = Post(author: "Какие лучшие сериалы стоит посмотреть в первой половине апреля 2022 года?", description: "Телевизионные новинки первой половины апреля 2022 года за редким исключением так или иначе связаны криминальной тематикой. В одних проектах мы встретимся с полицейскими и детективами, в других - с юристами, прокурорами и адвокатами, а благодаря третьим заглянем в святая святых британской контрразведки. Но есть и развлекательные, ориентированные на женскую аудиторию проекты", image: "1", likes: 0, views: 99)
        let post2 = Post(author: "Оскар 2022. Американская мечта в исполнении Уилла Смита", description: "Какие только меры не принимали организаторы церемонии вручения премий Американской Киноакадемии для спасения ежегодно падающего все больше рейтинга телевизионной трансляции. Каким только модным трендам не пытались следовать и каким только социальным группам не стремились угождать. Однако никакие реверансы, попытки усидеть на многих стульях и нелепые политические демарши ситуацию не спасали. Зрителей все меньше интересовало, кто получит заветные золотые статуэтки, и в каком платье появится на красной дорожке очередная звезда. Но Оскар 2022 запомнится всем. И вовсе не потому, что второй раз подряд в режиссерской номинации победила женщина, или из-за первого в истории успеха глухого актера.", image: "2", likes: 4, views: 7)
        let post3 = Post(author: "HBO Max разрабатывает два спин-оффа Шерлока Холмса", description: "HBO Max и Warner Bros. планируют выстроить кино- и телевселенную о Шерлоке Холмсе по образцу телевизионных спин-оффов фильмов ", image: "3", likes: 45, views: 87)
        let post4 = Post(author: "Объявлена дата премьеры второго сезона сериала В ритме жизни ", description: "Во втором сезоне Шейла Рубин (Бирн) успешно запускает свою первую видеокассету с фитнес-уроком только для того, чтобы столкнуться с новыми и более серьезными препятствиями на своем пути. Она разрывается между верностью к своему мужу (Рори Сковел) и ценностями, которые он представляет, и опасным влечением к кое-кому другому. И поскольку она больше не единственная, кто представляет фитнес в городе, ей приходится опережать некоторых новых свирепых конкурентов на пути к созданию полноценной фитнес-империи.", image: "4", likes: 33, views: 54)
        
        self.dataSource.append(post1)
        self.dataSource.append(post2)
        self.dataSource.append(post3)
        self.dataSource.append(post4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.addPostsInDataSource()
        self.tableView.reloadData()

    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        //скрываем заголовок navigationBar именно у этого navigationController
        self.navigationController?.navigationBar.isHidden = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.clear]
        navBarAppearance.backgroundColor = UIColor.clear

        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return self.dataSource.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = self.dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: post.author,
                                                    description: post.description,
                                                    image: post.image,
                                                    likes: post.publishedLikesAtString,
                                                    views: post.publishedViewsAtString)
        cell.setup(with: viewModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileHeaderView
        }else {
            let customHeader = UIView()
            customHeader.backgroundColor = .clear
            return customHeader
        }

    }
    
    //Устанавливаем значение высоты Заголовок Секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
