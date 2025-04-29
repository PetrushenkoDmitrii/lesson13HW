import UIKit

struct CellData {
    let title: String
    let image: UIImage?
    let imageBackgroundColor: UIColor?
    
    init(title: String, imageName: String, imageBackgroundColor: UIColor? = nil) {
        self.title = title
        self.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        self.imageBackgroundColor = imageBackgroundColor
    }
}

struct Section {
    let title: String?
    let items: [CellData]
}

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var sections: [Section] = [
        Section(title: "NETWORK", items: [
            CellData(title: "Cellular", imageName: "antenna.radiowaves.left.and.right", imageBackgroundColor: .systemGreen),
            CellData(title: "Personal Hotspot", imageName: "personalhotspot", imageBackgroundColor: .systemGreen)
        ]),
        Section(title: "SOUND & NOTIFICATIONS", items: [
            CellData(title: "Notifications", imageName: "app.badge", imageBackgroundColor: .systemOrange),
            CellData(title: "Sounds", imageName: "speaker.wave.2", imageBackgroundColor: .systemRed),
            CellData(title: "Do Not Disturb", imageName: "moon.fill", imageBackgroundColor: .systemPurple),
            CellData(title: "Screen Time", imageName: "hourglass", imageBackgroundColor: .systemPurple)
        ]),
        Section(title: "GENERAL", items: [
            CellData(title: "General", imageName: "gear", imageBackgroundColor: .systemGray),
            CellData(title: "Control Center", imageName: "switch.2", imageBackgroundColor: .systemGray),
            CellData(title: "Display & Brightness", imageName: "textformat.size", imageBackgroundColor: .systemBlue),
            CellData(title: "Wallpaper", imageName: "photo", imageBackgroundColor: .systemBlue),
            CellData(title: "Siri & Search", imageName: "mic", imageBackgroundColor: .systemPurple),
            CellData(title: "Touch ID & Passcode", imageName: "touchid", imageBackgroundColor: .systemRed),
            CellData(title: "Emergency SOS", imageName: "sos", imageBackgroundColor: .systemRed),
            CellData(title: "Battery", imageName: "battery.75", imageBackgroundColor: .systemGreen),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title = "Settings"
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "settingCell")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let item = sections[indexPath.section].items[indexPath.row]
        cell.configure(
            title: item.title,
            image: item.image,
            imageBackgroundColor: item.imageBackgroundColor
        )
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = sections[indexPath.section].items[indexPath.row]
        let settingsViewController = SettingsViewController(settings: selectedItem)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
