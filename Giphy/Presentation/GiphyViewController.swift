import UIKit

// Экран на котором показываются гифки
final class GiphyViewController: UIViewController {
    private lazy var alertPresenter: AlertPresenterProtocol = {
        var alpresenter = AlertPresenter()
        alpresenter.controller = self
        return alpresenter
    }()
    
    private var showedGifCounter: Int = 0 {
        didSet {
            counterLabel.text = "\(showedGifCounter)/10"
        }
    }

    private var likedGifCounter = 0

    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    // @IBOutlet UIImageView для Гифки
    @IBOutlet private weak var giphyImageView: UIImageView!
    
    // @IBOutlet UIActivityIndicatorView загрузки гифки, так как она может загрухаться долго
    @IBOutlet private weak var giphyActivityIndicatorView: UIActivityIndicatorView!

    // Нажатие на кнопку лайка
    @IBAction func onYesButtonTapped() {
        disableButtons(isYesButtonTapped: true)
        likedGifCounter += 1
        presenter.saveGif(giphyImageView.image)
        if showedGifCounter == 10 {
            showEndOfGiphy()
        } else {
            presenter.fetchNextGiphy()
        }
    }

    
    @IBAction func onNoButtonTapped() {
        disableButtons(isYesButtonTapped: false)
        if showedGifCounter == 10 {
            showEndOfGiphy()
        } else {
            presenter.fetchNextGiphy()
        }
    }

    // Слой Presenter - бизнес логика приложения, к которым должен общаться UIViewController
    private lazy var presenter: GiphyPresenterProtocol = {
        let presenter = GiphyPresenter()
        presenter.viewController = self
        return presenter
    }()

    // MARK: - Жизенный цикл экрана

    override func viewDidLoad() {
        super.viewDidLoad()

        giphyActivityIndicatorView.hidesWhenStopped = true
        restart()
    }
}

// MARK: - Приватные методы

private extension GiphyViewController {
    func disableButtons(isYesButtonTapped: Bool) {
        giphyImageView.layer.masksToBounds = true
        giphyImageView.layer.borderWidth = 8
        giphyImageView.layer.borderColor = isYesButtonTapped ? UIColor(named: "YPGreen")?.cgColor : UIColor(named: "YPRed")?.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self else { return }
            self.giphyImageView.image = nil
            self.giphyImageView.layer.borderWidth = 0
        }
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    func enableButtons() {
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }
    
    func updateCounterLabel() {
        showedGifCounter += 1
    }

    func restart() {
        showedGifCounter = 0
        likedGifCounter = 0
        presenter.fetchNextGiphy()
    }
}

// MARK: - GiphyViewControllerProtocol

extension GiphyViewController: GiphyViewControllerProtocol {
    func showError() {
        let alertModel = AlertModel(title: "Что-то пошло не так(", message: "невозможно загрузить данные", buttonText: "Попробовать еще раз") { [weak self] action in
            guard let self else { return }
            self.presenter.fetchNextGiphy()
        }
        alertPresenter.showAlert(alertModel)
    }

    func showEndOfGiphy() {
        let alertModel = AlertModel(title: "Мемы закончились!", message: "Вам понравилось: \(likedGifCounter)/10", buttonText: "Хочу посмотреть еще гифок") { [weak self] action in
            guard let self else { return }
            self.restart()
        }
        alertPresenter.showAlert(alertModel)
    }

    func showGiphy(_ image: UIImage?) {
        updateCounterLabel()
        giphyImageView.image = image
        enableButtons()
    }

    func showLoader() {
        giphyActivityIndicatorView.startAnimating()
    }

    // Остановить giphyActivityIndicatorView показа индикатора загрузки
    func hideLoader() {
        giphyActivityIndicatorView.stopAnimating()
    }
}
