
import Quick
import Nimble
@testable import AppTacToe

class BoardSpec: QuickSpec {
    
  override func spec() {
    
    var board: Board! // Defines a global 'board' to be used across test cases.
    
    beforeEach {
        board = Board() // Resets that 'board' to a new instance of 'Board' before every test using Quick's 'beforeEach' closuer.
    }
    
    describe("게임중에") { // 1. 'describe()' is used to define what action or behavior you'll be testing.
        context("한번 움직이면") { // 2. 'context()' is used to define the specific context of the action you'll be testing.
            it("nought로 바뀐다") { // 3. 'it()' is used to define the specific expected result for the test.
                try! board.playRandom() // 4. you play a random move on the 'Board' class using 'playRandom()'.
                
                expect(board.state).to(equal(.playing(.nought)))
                // 5. You assert the board's state has been changed to '.playing(.nought)'. This step used the 'equal()' matcher from Nimble, which is one of many available functions you can use to assert a matching of specific conditions on an expected value.
            }
        }
        
        
        context("two moves") { // 1. You define a new 'context()' to establish the "two moves" context.
            it("should switch back to cross") {
                try! board.playRandom() // 2. You play two consecutive random moves.
                try! board.playRandom()
                
                expect(board.state) == .playing(Board.Mark.cross) // 3. You assert the board's 'state' is now '.playing(.cross)'. Notice that this time you used the regular equality operator '==', instead of the '.to(equal))' syntax you used earlier. Nimble's 'equal()' matcher provides its own operator overloads that let you choose your own flavor/preference.
            }
        }
        
        
        context("a winning move") {
            it("should switch to won state") {
                // Arrange: You arrange the board to bring it to a state where the next move would be a winning move.
                //          You do this by playing the moves of both players at their turn; starting with X at 0, O at
                //          1, X at 3 and finally O at 2.
                try! board.play(at: 0)
                try! board.play(at: 1)
                try! board.play(at: 3)
                try! board.play(at: 2)
                
                // Act: You play 'X' at position 6. in the board's current state, playing at position 6 should cause a winning state.
                try! board.play(at: 6)
                
                // Assert: You assert the board's 'state' to be equal to won by cross(e.g. '.won(.cross)')
//               expect(board.state) == .won(.cross)
                expect(board).to(beWon(by: .nought))

//                debugPrint(board)
            }
        }
        
        
        context("a move leaving no remaining moves") {
          it("should switch to draw state") {
            // Arrange
            try! board.play(at: 0)
            try! board.play(at: 2)
            try! board.play(at: 1)
            try! board.play(at: 3)
            try! board.play(at: 4)
            try! board.play(at: 8)
            try! board.play(at: 6)
            try! board.play(at: 7)

            // Act
            try! board.play(at: 5)

            // Assert
            expect(board.state) == Board.State.draw
          }
        }
        
        
        context("a move that was already played") {
            it("should throw an error") {
                try! board.play(at: 0) // 1. You play a move at position 0.
                
                // 2. You play a move at the same positon, and expect it to throw 'Board.PlayerAError.alreadyPlayed'.
                //    When asserting error throwing, 'expect' takes a closure,
                //    in which you can run the code that causes the error to be throwin
                expect { try board.play(at: 0) }
                    .to(throwError(Board.PlayError.alreadyPlayed))
            }
        }

        
        context("a move while the game was already won") {
          it("should throw an error") {
            // Arrange
            try! board.play(at: 0)
            try! board.play(at: 1)
            try! board.play(at: 3)
            try! board.play(at: 2)
            try! board.play(at: 6)

            // Act & Assert
            expect { try board.play(at: 7) }
              .to(throwError(Board.PlayError.noGame))
          }
        }


    }
    
  }
}
