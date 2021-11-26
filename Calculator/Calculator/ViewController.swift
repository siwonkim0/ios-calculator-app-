import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var operandLabel: UILabel!
    @IBOutlet weak private var operatorLabel: UILabel!
    @IBOutlet weak private var expressionsStackView: UIStackView!
    @IBOutlet weak private var expressionScrollView: UIScrollView!
    
    private var calculator: Calculator?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        calculator = Calculator(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    private func initializeView() {
        operandLabel.text = CalculatorSymbol.Zero
        operatorLabel.text = String.empty
        removeSubviewsFromStackView()
    }
}

// MARK: - IBAction
extension ViewController {
    @IBAction private func touchUpOperandButton(_ sender: UIButton) {
        guard let operand = sender.currentTitle else { return }
        
        calculator?.operandButtonTouched(operand)
    }
    
    @IBAction private func touchUpOperatorButton(_ sender: UIButton) {
        guard let `operator` = sender.currentTitle else { return }
        
        calculator?.operatorButtonTouched(`operator`)
    }
    
    @IBAction private func touchUpACButton(_ sender: UIButton) {
        calculator?.allClearButtonTouched()
    }
    
    @IBAction private func touchUpCEButton(_ sender: UIButton) {
        calculator?.clearEntryButtonTouched()
    }
    
    @IBAction private func touchUpPlusMinusButton(_ sender: UIButton) {
        calculator?.plusMinusButtonTouched()
    }
    
    @IBAction private func touchUpDotButton(_ sender: UIButton) {
        calculator?.dotButtonTouched()
    }
    
    @IBAction private func touchUpResultButton(_ sender: UIButton) {
        calculator?.resultButtonTouched()
    }
}

// MARK: - View Method
extension ViewController {

    private func updateOperandsLabel(text operands: String) {
        operandLabel.text = operands
    }

    private func updateOperatorLabel(text operator: String) {
        operatorLabel.text = `operator`
    }

    private func addExpressionStackView() {
        let `operator` = makeLabel(with: operatorLabel.text)
        let operand = makeLabel(with: operandLabel.text)
        let expressionStackView = makeExpressionStackView(operator: `operator`,
                                                          operand: operand)

        expressionsStackView.addArrangedSubview(expressionStackView)
        scrollToBottom(expressionScrollView)
    }

    private func removeSubviewsFromStackView() {
        expressionsStackView.arrangedSubviews.forEach{$0.removeFromSuperview()}
    }
    
    private func makeExpressionStackView(operator: UILabel,
                                         operand: UILabel) -> UIStackView {
        let expression = UIStackView()
        let spacing: CGFloat = 8
        
        expression.axis = .horizontal
        expression.spacing = spacing
        expression.addArrangedSubview(`operator`)
        expression.addArrangedSubview(operand)
        
        return expression
    }
    
    private func makeLabel(with text: String?) -> UILabel {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = text
        
        return label
    }
        
    private func scrollToBottom(_ scroll: UIScrollView) {
        scroll.layoutIfNeeded()
        let offsetY = scroll.contentSize.height - scroll.bounds.size.height
        let bottomOffset = CGPoint(x: 0, y: offsetY)
        scroll.setContentOffset(bottomOffset, animated: true)
    }
}

extension ViewController: CalculatorDelegate {
    func calculator(didChangeCurrentOperandTo operand: String) {
        updateOperandsLabel(text: operand)
    }
    
    func calculator(didChangeCurrentOperatorTo operator: String) {
        updateOperatorLabel(text: `operator`)
    }
    
    func calculatorDidReceiveValidExpression() {
        addExpressionStackView()
    }
    
    func calculatorDidClearAllData() {
        removeSubviewsFromStackView()
    }
}
