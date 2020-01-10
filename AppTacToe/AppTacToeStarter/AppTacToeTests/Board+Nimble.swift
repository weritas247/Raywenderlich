
import Quick
import Nimble
@testable import AppTacToe

func beWon(by: Board.Mark) -> Predicate<Board> {
    return Predicate { expression in
        
        // 1. You try to evaluate the expression passed to 'expect()'. in this case, the expression is the board itself
        //    If the evaluation fails, you return a failing 'PredicateResult' with a proper message.
        guard let board = try expression.evaluate() else {
            return PredicateResult(status: .fail, message: .fail("failed evaluating expression"))
        }
        
        // 2. You confirm the board's state is equal to '.won(by)', where 'by' is the argument passed to the Matcher function.
        //    If the state doesn't match, you return a failing 'PredicateResult' with an '.expectedCustomValueTo' message.
        guard board.state == .won(by) else {
            return PredicateResult(status: .fail, message: .expectedCustomValueTo("be Won by \(by)", "\(board.state)"))
        }
        
        // 3. Finally, if everything looks good and verified, you return a successful PredicateResult.
        return PredicateResult(status: .matches, message: .expectedTo("expecation fulfilled"))
    }
}
