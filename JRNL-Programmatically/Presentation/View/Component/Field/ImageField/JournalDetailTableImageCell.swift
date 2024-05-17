//
//  JournalDetailTableImageCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

final class JournalDetailTableImageCell: BaseTableViewCell {
    override class var identifier: String { "JournalDetailTableImageCell" }
    
    // MARK - Components
    private lazy var journalImageView: UIImageView = {
        let journalImageView = UIImageView()
        journalImageView.contentMode = .scaleAspectFit
        
        return journalImageView
    }()
    
    override func configureUI() {
        addSubview(journalImageView)

        journalImageView.translatesAutoresizingMaskIntoConstraints = false

        let global = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            journalImageView.widthAnchor.constraint(equalToConstant: 300),
            journalImageView.heightAnchor.constraint(equalToConstant: 300),
            journalImageView.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            journalImageView.centerYAnchor.constraint(equalTo: global.centerYAnchor),
        ])
    }
    
    override func setup(with contentType: CellContentType) {
        if case let .image(data) = contentType {
            if let photoData = data {
                journalImageView.image = UIImage(data: photoData)
            } else {
                journalImageView.image = UIImage(systemName: "sun.max")
            }
        } else {
            debugPrint("JournalDetailTableImageCell setup(with:) malfucntioning")
        }
    }
}

