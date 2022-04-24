import UIKit
import Kingfisher

/// Класс, отвечающий за представление экрана детализированной информации о событии
final class DetailViewController: UIViewController {
	private let output: DetailViewOutput
    
    private let titleLabel = UILabel()
    private let addressLabel = UILabel()
    private let descriptionLabel = UITextView()
    private let priceLabel = UILabel()
    private let iconImageView = UIImageView()
    private let containerView = UIView()
    private let ageRestrictionLabel = UILabel()
    private let categoryLabel = UITextView()
    private var site_url: String?
    private var addressImageView = UIImageView()
    
    private let selectedImg = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    private let defaultImg = UIImage(systemName: "heart")
    let buttonUrl = CustomButtonBuilder().getCustomButton(title: "Перейти на сайт")
    
    private let scrollView = UIScrollView()
    private let priceImageView = UIImageView()

    init(output: DetailViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Событие"
        setup()
        output.didLoadView()
	}
    
    private func setup() {
        containerView.clipsToBounds = true
        
        addressImageView.image = UIImage(named: "address")
        priceImageView.image = UIImage(named: "rub")
    
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        addressLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        addressLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        priceLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .light)
        descriptionLabel.isEditable = false
        buttonUrl.addTarget(self,action: #selector(buttonUrlAction),
                         for: .touchUpInside)
        ageRestrictionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        categoryLabel.font = .systemFont(ofSize: 15, weight: .thin)
        categoryLabel.textColor = .red
        categoryLabel.isEditable = false
      
        [titleLabel, addressLabel, descriptionLabel, priceLabel, iconImageView, buttonUrl, ageRestrictionLabel, categoryLabel, addressImageView, priceImageView].forEach {
            containerView.addSubview($0)
        }
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all()
        
        containerView.pin.all()
        
        iconImageView.pin
            .size(250)
            .top(5)
            .hCenter()
        
        titleLabel.pin
            .below(of: iconImageView)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
        
        addressImageView.pin
            .size(20)
            .below(of: titleLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
        
        addressLabel.pin
            .below(of: titleLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 40)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
        
        priceImageView.pin
            .size(20)
            .below(of: addressImageView)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
        
        priceLabel.pin
            .below(of: addressLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 40)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
        
        ageRestrictionLabel.pin
            .below(of: priceLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: ageRestrictionLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)

        buttonUrl.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
        
        categoryLabel.pin
            .below(of: buttonUrl)
            .marginTop(10)
            .left(view.pin.safeArea.left + 10)
            .right(view.pin.safeArea.right + 10)
            .sizeToFit(.width)
    }
    
    private func configure(with model: DetailViewModel) {
        titleLabel.text = model.title
        addressLabel.text = model.address
        priceLabel.text = model.price
        descriptionLabel.text = model.description
        iconImageView.kf.setImage(with: URL(string: model.image ?? ""))
        ageRestrictionLabel.text = model.age_restriction
        categoryLabel.text = model.category
        
        if model.isInFavorites {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedImg, style: .done, target: self, action: #selector(didTapFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: defaultImg, style: .done, target: self, action: #selector(didTapFavorites))
        }
        
    }
    
    /// Вызывается при нажатии на ссылку события
    @objc
    func buttonUrlAction() {
        output.didTapButtonUrl()
    }
    
    private func isSelectedToFavorites() -> Bool {
        return navigationItem.rightBarButtonItem?.image == selectedImg
    }
    
    /// Вызывается при нажатии на кнопку обновления статуса избранного
    @objc
    func didTapFavorites() {
        if isSelectedToFavorites() {
            navigationItem.rightBarButtonItem?.image = defaultImg
            removeFromFavorites()
        } else {
            navigationItem.rightBarButtonItem?.image = selectedImg
            addToFavorites()
        }
    }
    
    private func addToFavorites() {
        output.didTapAddToFavorites()
    }
    
    private func removeFromFavorites() {
        output.didTapRemoveFromFavorites()
    }
}

extension DetailViewController: DetailViewInput {
    func loadData(with model: DetailViewModel) {
        configure(with: model)
    }
}



