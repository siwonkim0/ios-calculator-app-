import Foundation

class Calculator {
    weak private var delegate: CalculatorDelegate?
    
    var currentOperator: String {
        didSet {
            delegate?.calculator(didChangeCurrentOperatorTo: currentOperator)
        }
    }
    
    var currentOperand: String {
        didSet {
            delegate?.calculator(didChangeCurrentOperandTo: currentOperand)
        }
    }
    
    var inputString: String
    
    private let numberFormatter = NumberFormatter()
    
    private var hasSuffixOperator: Bool {
        return Operator.allCases.reduce(false) {
            $0 == inputString.hasSuffix(String($1.rawValue))
        }
    }
    
    private var hasDot: Bool {
        return currentOperand.contains(CalculatorSymbol.Dot)
    }
    
    init(currentOperator: String = String.empty,
         currentOperand: String = CalculatorSymbol.Zero,
         inputString: String = String.empty) {
        self.currentOperator = currentOperator
        self.currentOperand = currentOperand
        self.inputString = inputString
        self.initNumberFormatter()
    }
    
    convenience init(delegate: CalculatorDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    private func resetCurrentData() {
        resetCurrentOperand()
        resetCurrentOperator()
        delegate?.calculatorDidClearAllData()
    }
    
    private func initNumberFormatter() {
        numberFormatter.roundingMode = .ceiling
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 20
    }
}

// MARK: -Receive Event
extension Calculator {
    func operandButtonTouched(_ operand: String) {
        changeCurrentOperand(text: operand)
    }
    
    func operatorButtonTouched(_ operator: String) {
//        guard let `operator` = sender.currentTitle else { return }
//        guard let currentText = operandLabel.text else { return }
//
//        if currentText == CalculatorSymbol.Zero {
//            updateOperatorLabel(text: `operator`)
//            appendOperatorToInputString()
//            return
//        }
//
//        addExpressionStackView()
//        updateOperatorLabel(text: `operator`)
//        appendOperandToInputString()
//        appendOperatorToInputString()
//        resetOperandLabel()
    }
    
    func allClearButtonTouched() {
        resetInputString()
        resetCurrentData()
    }
    
    func clearEntryButtonTouched() {
//        resetOperandLabel()
    }
    
    func plusMinusButtonTouched() {
//        guard operandLabel.text != CalculatorSymbol.Zero else {
//            return
//        }
//
//        togglePlusMinus()
    }
    
    func dotButtonTouched() {
        //insertDot()
    }
    
    func resultButtonTouched() {
//        guard let `operator` = operatorLabel.text,
//              `operator` != String.empty else { return }
//
//        addExpressionStackView()
//        appendOperandToInputString()
//        resetOperatorLabel()
//
//        var formula = ExpressionParser.parse(from: inputString)
//        let result = formula.result()
//        operandLabel.text = numberFormatter.string(for: result)
    }
}

// MARK: Private Method
extension Calculator {
    private func changeCurrentOperand(text: String) {
        var currentText = currentOperand
        
        guard currentText != CalculatorSymbol.Zero ||
                text != CalculatorSymbol.DoubleZero else {
                    return
                }
        
        if currentText == CalculatorSymbol.Zero {
            currentText = text
        } else {
            currentText += text
        }
        
        if hasDot == false {
            let numberLabelText = currentText.removedComma()
            let number = Double(numberLabelText)
            currentOperand = numberFormatter.string(for: number) ?? CalculatorSymbol.Zero
        } else {
            currentOperand = currentText
        }
    }
    
    private func resetCurrentOperand() {
        currentOperand = CalculatorSymbol.Zero
    }
    
    private func resetCurrentOperator() {
        currentOperator = String.empty
    }
    
    private func resetInputString() {
        inputString = String.empty
    }
}
extension Calculator {
    
}
