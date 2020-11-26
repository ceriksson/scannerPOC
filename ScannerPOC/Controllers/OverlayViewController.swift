import UIKit
import CardScan

class OverlayViewController: UIViewController, SimpleScanDelegate {
    func userDidCancelSimple(_ scanViewController: SimpleScanViewController) {
        print("🤨")
    }
    
    func userDidScanCardSimple(_ scanViewController: SimpleScanViewController, creditCard: CreditCard) {
        print("😃 " + creditCard.number)
        // First, notify the child that it’s about to be removed
        vc.willMove(toParent: nil)

        // Then, remove the child from its parent
        vc.removeFromParent()

        // Finally, remove the child’s view from the parent’s
        vc.view.removeFromSuperview()
        
        addForm(cardNumber: String(creditCard.number))
    }
    
    let vc = SimpleScanViewController.createViewController()
    let viewtitle = UILabel()
    let button = UIButton()
    let textField = UITextField()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
//    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var scanButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        vc.delegate = self
        addTitle()
        addScanner(vc)
        addButton()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func addScanner(_ controller: SimpleScanViewController) {
        addChild(controller)
        let newView = controller.view!
        view.addSubview(controller.view)
        
        controller.descriptionText.text = ""
        controller.closeButton.setTitle("", for: .normal)
        controller.torchButton.setTitle("", for: .normal)
        
        //constraints
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = newView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 60)
        let heightConstraint = newView.heightAnchor.constraint(equalToConstant: ((self.view.frame.size.width - 60) * 2) / 3)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        controller.didMove(toParent: self)
    }
    
    func addTitle() {
        viewtitle.text = "Scan a card"
        viewtitle.textColor = .darkGray
        viewtitle.textAlignment = .center
        viewtitle.font = UIFont.boldSystemFont(ofSize: 20)
        viewtitle.frame = CGRect(x: 12, y: 20, width: self.view.frame.size.width - 24, height: 60)
        self.view.addSubview(viewtitle)
    }
    
    func addButton() {
        button.frame = CGRect(x: (self.view.frame.size.width / 2) - 100, y: (self.view.frame.size.height / 2) - 10, width: 200, height: 60)
        
        button.setTitle("Manual input", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        
        self.view.addSubview(button)
        
    }
    
    func addForm(cardNumber: String) {
        textField.frame = CGRect(x: 12, y: 100, width: self.view.frame.size.width - 24, height: 60)
        textField.text = cardNumber
        textField.textColor = .darkGray
        textField.backgroundColor = .systemPink
        self.view.addSubview(textField)
    }
    
}

//extension ViewController: UIViewControllerTransitioningDelegate {
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        PresentationController(presentedViewController: presented, presenting: presenting)
//    }
//}
