import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lableKek: UILabel!
    
    let abc = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let sumbols = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "{", "}", "|", ";", ":"]
    
    let combinated = ["abc", "numbers", "sumbols"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание распознавателя жестов долгого нажатия
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        lableKek.addGestureRecognizer(longPressGesture)
        
        // Включение взаимодействия с пользователем для метки
        lableKek.isUserInteractionEnabled = true
    }
    
    @IBAction func buttonPush(_ sender: Any) {
        var counter = 0
        var result = ""
        
        while counter < 8 {
            if let randomCombinated = combinated.randomElement() {
                switch randomCombinated {
                case "abc":
                    if let element = abc.randomElement() {
                        result += element
                    }
                case "numbers":
                    if let element = numbers.randomElement() {
                        result += element
                    }
                case "sumbols":
                    if let element = sumbols.randomElement() {
                        result += element
                    }
                default:
                    break
                }
                counter += 1
            }
        }
        
        lableKek.text = result
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            becomeFirstResponder()
            
            // Создаем и отображаем меню
            let menuController = UIMenuController.shared
            let copyMenuItem = UIMenuItem(title: "Копировать", action: #selector(copyText))
            menuController.menuItems = [copyMenuItem]
            
            if let targetView = gesture.view {
                menuController.showMenu(from: targetView, rect: targetView.bounds)
            }
        }
    }
    
    // Делает ViewController первым респондентом
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc func copyText() {
        // Копирование текста метки в буфер обмена
        UIPasteboard.general.string = lableKek.text
    }
}
