# Programmatic UITableView

This is an app made following the [tutorial](https://youtube.com/playlist?list=PLJbKhtS4qyYR7WSqTs5V0B0xx3iH7_Iyo) created by Martin Lasek on creating a UITableView without the use of storyboards.

<p align="center">
    <img src="asset/uitableview.gif" alt="An app represeting a table view with rows of amiibos, touching a row would present a detail view and swiping a row would present on the left a count up action and on right a delete action">
</p>

## Delete Storyboard

Delete Storyboard.main

Delete Reference to Main in General > Deployment Info > Main Interface

<img src="asset/delete-storyboard.png" alt="Empty reference of the main interface in the project.">

## Change the start of the App Code

On iOS 12 the AppDelegate should look like this:
```
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AmiiboListVC()
        window?.makeKeyAndVisisble()

        return true
    }

}
```

On iOS 13 the AppDelegate should look like this:
```
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishingLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:Any]) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSessionRole.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when a user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
```

The SceneDelegate would take the UIWindow object and should look like this:
```
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, sceneWillConnectTo: session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForconnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = AmiiboListVC()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
```

## Build the UITableViewController

The AmiiboListVC is a UIViewController with a UITableView object representing the view and the viewDidLoad method is used to configure the view managed by the view controller.

```
class AmiiboListVC: UIViewController {
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    // MARK: - Setup
    func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equaltTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
```

## TableViewDataSource

The AmiiboListVC can conform to the UITableViewDataSource protocol so it can displays some data in some rows.

```
// MARK: - UITableViewDataSouce
extension AmiiboListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hey! Listen!"
        return cell
    }
}
```

We need to assing the view controller as a data source of the table view `tableView.dataSource = self`

The optimization of the cell is done using a reusable cell `let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)`

## TableViewDelegate

The AmiiboListVC can conform to the UITableViewDelegate protocol so it can enable some sort of actions like swiping and presenting some other views from touching a row.

```
extension AmiiboListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UIViewController()
        self.present(detailViewController, animated: true)
    }
}
```

We need to assign the view controller as a delegate of the table view `tableView.delegate = self`

## Custom UITableViewCell

We can create a custom cell subclassing a UITableViewCell.

```
class AmiiboCell: UITableViewCell {
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    let owningCountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }

    // MARK: Setup
    func setupView() {
        setupOwningCountingLabel()
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
    }

    func setupOwningCountingLabel() {
        addSubview(owningCountLabel)

        owningCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraints.activate([
            owningCountingLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            owningCountingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupImageView() {
        ...
    }

    func setupNameLabel() {
        ...
    }

    func setupGameSeriesLabel() {
        ...
    }
}
```

## AmiiboAPI

To download some data from an API we a data task from an URLSession.

```
final class AmiiboAPI {

    static let shared = AmiiboAPI()

    func fetchAmiiboList(onCompletion: @escaping ([Amiibo] -> ())) {
        let urlString = "https://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else {
                print("Data was nil")
                return
            }

            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("Couldn't decode from JSON")
                return
            }

            onCompletion(amiiboList.amiibo)
        }

        task.resume()
    }
}
```

## Custom ImageView

We can subclass an ImageView so we can customized it so it can have features like loading an image from the cache or from a URL meanwhile having a spinner indicating is loding it.

```
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner: UIActivityIndicator(style: .medium)

    func loadImage(from url: URL) {
        image = nil

        addSpinner()

        if let task = task {
            task.cancel()
        }

        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) else {
            image = imageFromCache
            removeSpinner()
            return
        }

        task = URLSession.dataTask(with: url) { (data, resp, error) in

            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("Couldn't load image from url: \(url)")
                return
            }

            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)

            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }

        task.resume()
    }

    func addSpinner() {
        addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        spinner.startAnimating()
    }

    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
```