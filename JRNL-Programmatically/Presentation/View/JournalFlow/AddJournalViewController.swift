//
//  AddJournalViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit
import Combine
import PhotosUI

final class AddJournalViewController: UIViewController {
    // MARK: - Components
    private lazy var mainContainer: UIStackView = {
        let mainContainer = UIStackView()
        mainContainer.axis = .vertical
        mainContainer.alignment = .center
        mainContainer.distribution = .fill
        mainContainer.spacing = 40
        
        return mainContainer
    }()
    
    private lazy var topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.spacing = 0
        topStackView.backgroundColor = .systemCyan
        
        return topStackView
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        
        return switchView
    }()
    
    private lazy var switchLabel: UILabel = {
        let switchLabel = UILabel()
        switchLabel.text = "switch label"
        
        return switchLabel
    }()
    
    private lazy var switchContainer: UIStackView = {
        let switchContainer = UIStackView()
        switchContainer.axis = .horizontal
        switchContainer.alignment = .fill
        switchContainer.distribution = .fill
        switchContainer.spacing = 8
        
        return switchContainer
    }()
    
    private lazy var journalTextField: UITextField = {
        let journalTextField = UITextField()
        journalTextField.placeholder = "Journal Title"
        
        return journalTextField
    }()
    
    private lazy var journalTextView: UITextView = {
        let journalTextView = UITextView()
        journalTextView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        return journalTextView
    }()
    
    private lazy var journalImage: UIImage? = nil 
    
    private lazy var journalImageView: UIImageView = {
        let journalImageView = UIImageView()
        journalImageView.image = UIImage(systemName: "face.smiling")
        journalImageView.image = journalImage ?? UIImage(systemName: "face.smiling")
        journalImageView.isUserInteractionEnabled = true
        journalImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(presentPicker)
            )
        )
        
        return journalImageView
    }()
    
    private let viewModel: AddJournalViewModel
    private var disposableBag = Set<AnyCancellable>()
    
    init(viewModel: AddJournalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationItems()
        bind()
    }
    
    func bind() {
        viewModel
            .$isSuccess
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] condition in
                if condition { self?.dismiss(animated: true) }
            }
            .store(in: &disposableBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        switchContainer.addArrangedSubview(switchView)
        switchContainer.addArrangedSubview(switchLabel)
        
        mainContainer.addArrangedSubview(topStackView)
        mainContainer.addArrangedSubview(switchContainer)
        mainContainer.addArrangedSubview(journalTextField)
        mainContainer.addArrangedSubview(journalTextView)
        mainContainer.addArrangedSubview(journalImageView)
        
        view.addSubview(mainContainer)
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        switchContainer.translatesAutoresizingMaskIntoConstraints = false
        journalTextField.translatesAutoresizingMaskIntoConstraints = false
        journalTextView.translatesAutoresizingMaskIntoConstraints = false
        journalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: global.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: global.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: global.trailingAnchor, constant: -20),
            
            topStackView.widthAnchor.constraint(equalToConstant: 252),
            topStackView.heightAnchor.constraint(equalToConstant: 44),
            
            journalTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            journalTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),

            journalTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            journalTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            journalTextView.heightAnchor.constraint(equalToConstant: 128),
            
            journalImageView.widthAnchor.constraint(equalToConstant: 200),
            journalImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "New Entry"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveEntry)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancel)
        )
    }
    
    @objc private func saveEntry() {
        guard let title = journalTextField.text else { return }
        guard let description = journalTextView.text else { return }
        
        viewModel.save(
            with: Journal(
                rating: 5,
                journalTitle: title,
                journalDescription: description,
                photoData: nil
            )
        )
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    @objc private func presentPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension AddJournalViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                Task {
                    if let error {
                        debugPrint("PHPhotoError: \(error.localizedDescription)")
                        return
                    }
                    
                    await MainActor.run {
                        guard let self = self,
                              let image = image as? UIImage
                        else { return  }
                        self.journalImage = image
                        self.journalImageView.image = image
                    }
                }
            }
        }
    }
}
}
