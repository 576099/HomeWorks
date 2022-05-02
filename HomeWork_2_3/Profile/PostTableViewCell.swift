//
//  PostTableViewCell.swift
//  HomeWork_2_3
//
//  Created by Александр Смирнов on 05.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let author: String
        let description: String
        let image: String
        let likes: String
        let views: String
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView1: UIImageView = {
        let imageView1 = UIImageView()
//        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.contentMode = .scaleAspectFit
        imageView1.backgroundColor = .black
        imageView1.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        imageView1.clipsToBounds = true
        return imageView1
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(500), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 200
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.backView)
        self.backView.addSubview(stackView)
        
        self.stackView.addArrangedSubview(self.authorLabel)
        self.stackView.addArrangedSubview(self.imageView1)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.stackViewHorizontal)
        self.stackViewHorizontal.addArrangedSubview(likesLabel)
        self.stackViewHorizontal.addArrangedSubview(viewsLabel)
        let backViewConstraints = self.backViewConstraints()
        
        let stackViewConstraints = self.stackViewConstraints()
        NSLayoutConstraint.activate(backViewConstraints + stackViewConstraints)
    }

    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 10)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -10)
        let bottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -10)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    private func authorLabelViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.authorLabel.topAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: 16)
        let leadingConstraint = self.authorLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        
        return [
            topConstraint, leadingConstraint
        ]
    }
    private func imageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.imageView1.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12)
        let centerXConstraimt = self.imageView1.centerXAnchor.constraint(equalTo: self.backView.centerXAnchor)
        let heightConstraint = self.imageView1.heightAnchor.constraint(equalTo: self.backView.widthAnchor)
        let widthConstraint = self.imageView1.widthAnchor.constraint(equalTo: self.backView.widthAnchor)

        return [
            topConstraint, heightConstraint, widthConstraint, centerXConstraimt
        ]
    }
    
    private func descriptionLabelConstraint() -> [NSLayoutConstraint] {
        let topConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.imageView1.bottomAnchor, constant: 16)
        let leadingConstraint = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        
        return [
            topConstraint, leadingConstraint, trailingConstraint
        ]
    }
    
    private func likesLabelConstraint() -> [NSLayoutConstraint] {
        let topConstraint = self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingConstraint = self.likesLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        
        return [
            topConstraint, leadingConstraint
        ]
    }
    private func viewsLabelConstraint() -> [NSLayoutConstraint] {
        let topConstraint = self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let trailingConstraint = self.viewsLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        
        return [
            topConstraint, trailingConstraint
        ]
    }

}

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.authorLabel.text = viewModel.author
        self.descriptionLabel.text = viewModel.description
        self.imageView1.image = UIImage(named: viewModel.image)
        self.likesLabel.text = viewModel.likes
        self.viewsLabel.text = viewModel.views
    }
}
