import UIKit

// Экран на котором показываются гифки
final class GiphyViewController: UIViewController {
    // Переменная Int -- Счетчик залайканых или задизлайканных гифок
    // Например showdGifCounter -- счетчика показанных гифок

    // Переменная Int -- Количество понравившихся гифок
    // Например likedGifCounter -- счетчик любимых гифок

    // @IBOutlet UILabel для счетчика гифок, например 1/10
    // Например -- @IBOutlet weak var counterLabel: UILabel!

    // @IBOutlet UIImageView для Гифки
    // Например -- @IBOutlet weak var giphyImageView: UIImageView!

    // @IBOutlet UIActivityIndicatorView загрузки гифки, так как она может загрухаться долго
    @IBOutlet weak var giphyActivityIndicatorView: UIActivityIndicatorView!

    // Нажатие на кнопку лайка
    @IBAction func onYesButtonTapped() {
        // Проверка на то просмотрели или нет 10 гифок

        // Если все 10 гифок просомтрели необходимо показать UIAlertController о завершении
        // При нажатии на кнопку в UIAlertController необходимо сбросить счетчики и начать сначала

        // Иначе, если еще не просмотрели 10 гифок, то увеличиваем счетчик и обновляем UIlabel с счетчиком

        // Сохраняем понравившуюся гифку
        // presenter.saveGif(<Созданный UIImageView для @IBOutlet>.image)
        // Например -- presenter.saveGif(giphyImageView.image)

        // Загружаем следующую гифку
        // presenter.fetchNextGiphy()
    }

    // Нажатие на кнопку дизлайка
    @IBAction func onNoButtonTapped() {
        // Проверка на то просмотрели или нет 10 гифок

        // Если все 10 гифок просомтрели необходимо показать UIAlertController о завершении
        // При нажатии на кнопку в UIAlertController необходимо сбросить счетчики и начать

        // Иначе, если еще не просмотрели 10 гифок, то увеличиваем счетчик и обновляем UIlabel с счетчиком

        // Загружаем следующую гифку
        // presenter.fetchNextGiphy()
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

        restart()
    }
}

// MARK: - Приватные методы

private extension GiphyViewController {
    // Учеличиваем счетчик просмотренных гифок на 1
    // Обновляем UILabel который находится в верхнем UIStackView и отвечает за количество просмотренных гифок
    // Обновляем счетчик просмотренных гифок UIlabel
    func updateCounterLabel() {
    }

    // Перезапускаем счетчики просмотренных гифок и понравивишихся гифок
    // Обновляем UILabel который находится в верхнем UIStackView и отвечает за количество просмотренных гифок
    // Загружаем гифку
    func restart() {
        // presenter.fetchNextGiphy()
    }
}

// MARK: - GiphyViewControllerProtocol

extension GiphyViewController: GiphyViewControllerProtocol {
    // Показ ошибки UIAlertController, что не удалось загрузить гифку
    func showError() {
        // Необходимо показать UIAlertController
        // Заголовок -- Что-то пошло не так(
        // Сообщение -- не возможно загрузить данные
        // Кнопка -- Попробовать еще раз
        //
        // При нажатии на кнопку необходимо перезагрузить гифку
    }

    func showEndOfGiphy() {
        // Необходимо показать UIAlertController
        // Заголовок -- Мемы закончились!
        // Сообщение -- Вам понравилось: \(n)\\10
        // Кнопка -- Хочу посмотреть еще гифок
        //
        // При нажатии сбросить все счетчики -- вызов метода restart
    }

    // Показать гифку UIImage
    func showGiphy(_ image: UIImage?) {
        // giphyImageView.image = image
    }

    // Показать лоадер
    // Присвоить UIImageView.image = nil
    // Вызвать giphyActivityIndicatorView показа индикатора загрузки
    func showLoader() {
        // presenter.saveGif(<Созданный UIImageView для @IBOutlet>.image)
        // Например -- presenter.saveGif(giphyImageView.image)

        giphyActivityIndicatorView.startAnimating()
    }

    // Остановить giphyActivityIndicatorView показа индикатора загрузки
    func hideHoaler() {
        giphyActivityIndicatorView.stopAnimating()
    }
}
