import UIKit

class ViewController: UIViewController {
    
  // - Variables
  @IBOutlet var currentQuestionLabel: UILabel!
  @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
  @IBOutlet var nextQuestionLabel: UILabel!
  @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
  @IBOutlet var answerLabel: UILabel!
  
  let questions: [String] = [
      "What is 7+7?",
      "What is the capital of Vermont?",
      "What is cognac made from?"
  ];
  
  let answers: [String] = [
      "14",
      "Montpelier",
      "Grapes"
  ];

  var currentQuestionIndex: Int = 0;
  
  // - Methods:
  @IBAction func showNextQuestion(_ sender: UIButton) {
      currentQuestionIndex += 1
      if currentQuestionIndex == questions.count {
          currentQuestionIndex = 0
      }
      
      let question: String = questions[currentQuestionIndex]
      nextQuestionLabel.text = question
      answerLabel.text = "???"
      
      animateLabelTransitions()
  }
  
  @IBAction func showAnswer(_ sender: UIButton) {
      let answer: String = answers[currentQuestionIndex]
      answerLabel.text = answer
  }
  
  // - Functions
  func animateLabelTransitions() {
      view.layoutIfNeeded()
      
      let screenWidth = view.frame.width
      self.nextQuestionLabelCenterXConstraint.constant = 0
      self.currentQuestionLabelCenterXConstraint.constant += screenWidth
      UIView.animate(withDuration: 0.5,
                      delay: 0.10,
                      usingSpringWithDamping: 0.3,
                      initialSpringVelocity: 0.02,
                      options: [.curveEaseOut],
                      animations: {
                      self.currentQuestionLabel.alpha = 0
                      self.nextQuestionLabel.alpha = 1
                      self.view.layoutIfNeeded()
      },
                      completion: { _ in
                      swap(&self.currentQuestionLabel,
                            &self.nextQuestionLabel)
                      swap(&self.currentQuestionLabelCenterXConstraint,
                            &self.nextQuestionLabelCenterXConstraint)
                      self.updateOffScreenLabel()
      })
      
  }
  
  func updateOffScreenLabel() {
      let screenWidth = view.frame.width
      nextQuestionLabelCenterXConstraint.constant = -screenWidth
  }
  
  // - Override
  override func viewDidLoad() {
      super.viewDidLoad()
      currentQuestionLabel.text = questions[currentQuestionIndex]
      updateOffScreenLabel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // Set the label's initial alpha
      
      nextQuestionLabel.alpha = 0
  }
}
