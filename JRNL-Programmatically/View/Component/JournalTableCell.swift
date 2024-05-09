//
//  JournalTableCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit

final class JournalTableCell: UITableViewCell {
    
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "title label"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "description label"
        
        return descriptionLabel
    }()
    
    private lazy var thumbnailView: UIImageView = {
        let thumbnailView = UIImageView()
        thumbnailView.image = UIImage(systemName: "face.smiling")
        
        return thumbnailView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let global = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: global.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: global.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: global.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: global.trailingAnchor, constant: 8)
        ])
    }
}
