Class {
	#name : #SquareEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'squareEffect-tests' }
SquareEffectTest >> testApplyAtomicBombToAGamePiece [
	| player1 player2 dices1 judge board players gamepiece1 gamepiece2 gamepieces squares effect0 effect1 effect2 square0 square1 square2 dices2 |
	gamepiece1 := Gamepiece withColor: 'pink'.
	gamepiece2 := Gamepiece withColor: 'blue'.
	gamepieces := Dictionary
		newFrom:
			{(gamepiece1 color -> gamepiece1).
			(gamepiece2 color -> gamepiece2)}.
	effect0 := NonEffect new.
	effect1 := AtomicBomb new.
	effect2 := NonEffect new.
	square0 := Square withAnEffect: effect0 thatGivesCard: false.
	square1 := Square withAnEffect: effect1 thatGivesCard: false.
	square2 := Square withAnEffect: effect2 thatGivesCard: false.
	squares := Dictionary
		newFrom:
			{(0 -> square0).
			(1 -> square1).
			(2 -> square2)}.
	player1 := Player
		withName: 'Sol'
		aGamePiece: gamepiece1
		aCard: (Overload withValueAndID: 1)
		andOtherCard: (Overload withValueAndID: 2).
	player2 := Player
		withName: 'Dubi'
		aGamePiece: gamepiece2
		aCard: (Overload withValueAndID: 3)
		andOtherCard: (Overload withValueAndID: 4).
	players := OrderedCollection new.
	players
		add: player1;
		add: player2.
	dices1 := Set new.
	dices1 add: (LoadedDice withFaces: 2).
	dices2 := Set new.
	dices2 add: (LoadedDice withFaces: 4).
	board := Board withSquares: squares gamepieces: gamepieces andRounds: 2.
	judge := Judge named: 'Pitana' assuring: players on: board.
	judge validateTurnOf: player1.
	player1 playsATurnWith: dices1.
	judge validateRoundsOfPlayers.
	board updateGamepiecesPositionOnBoard.
	board applyEffectToAGamepieceUsingKey: gamepiece1 color.
	judge changeTurnOfPlayers.
	judge validateTurnOf: player2.
	player2 playsATurnWith: dices2.
	judge validateRoundsOfPlayers.
	board updateGamepiecesPositionOnBoard.
	board applyEffectToAGamepieceUsingKey: gamepiece2 color.
	judge changeTurnOfPlayers.
	board updateGamepiecesPositionOnBoard.
	self assert: gamepiece1 position equals: 0.
	self assert: gamepiece1 positionOnBoard equals: 0.
	self assert: gamepiece2 position equals: 3.
	self assert: gamepiece2 positionOnBoard equals: 0
]

{ #category : #'squareEffect-tests' }
SquareEffectTest >> testApplyMoonWalkToAGamePiece [
	| effect1 effect2 gamepiece1 gamepiece2 gamepiece3 pieces |
	effect1 := SpeedUp withAPowerValue: 4.
	gamepiece1 := Gamepiece withColor: 'pink'.
	effect1 applyEffectTo: gamepiece1 ofGamepieceCollection: #().
	self assert: gamepiece1 position equals: 4.
	gamepiece2 := Gamepiece withColor: 'blue'.
	effect1 applyEffectTo: gamepiece2 ofGamepieceCollection: #().
	effect1 applyEffectTo: gamepiece2 ofGamepieceCollection: #().
	gamepiece3 := Gamepiece withColor: 'deep-purple'.
	effect1 applyEffectTo: gamepiece3 ofGamepieceCollection: #().
	effect1 applyEffectTo: gamepiece3 ofGamepieceCollection: #().
	effect1 applyEffectTo: gamepiece3 ofGamepieceCollection: #().
	self assert: gamepiece3 position equals: 12.
	effect2 := MoonWalk withAPowerValue: 3.
	pieces:= OrderedCollection new. 
	pieces add: gamepiece1;
	add:gamepiece2;
	add:gamepiece3. 
	effect2 applyEffectTo: gamepiece1 ofGamepieceCollection: pieces.   
	self
		assert: gamepiece1 position
		equals: 4.
	self assert: gamepiece2 position equals: 5.
	self assert: gamepiece3 position equals: 9
]

{ #category : #'squareEffect-tests' }
SquareEffectTest >> testApplyNonEffectToGamePiece [
	| effect1 gamepiece effect2 |
	effect1 := SpeedUp withAPowerValue: 4.
	gamepiece := Gamepiece withColor: 'pink'.
	effect1 applyEffectTo: gamepiece ofGamepieceCollection: #().
	self assert: gamepiece position equals: 4.
	effect2 := NonEffect new.
	effect2 applyEffectTo: gamepiece ofGamepieceCollection: #().
	self assert: gamepiece position equals: 4.
]

{ #category : #'squareEffect-tests' }
SquareEffectTest >> testApplySpeedUpToAGamePiece [
	| effect gamepiece |
	effect := SpeedUp withAPowerValue: 4.
	gamepiece := Gamepiece withColor: 'pink'.
	effect applyEffectTo: gamepiece ofGamepieceCollection: #().
	self assert: gamepiece position equals: 4
]

{ #category : #'squareEffect-tests' }
SquareEffectTest >> testApplyWormHoleToAGamePiece [
	| effect1 effect2 gamepiece |
	effect1 := SpeedUp withAPowerValue: 4.
	gamepiece := Gamepiece withColor: 'pink'.
	effect1 applyEffectTo: gamepiece ofGamepieceCollection: #().
	self assert: gamepiece position equals: 4.
	effect2 := WormHole withAPowerValue: 4.
	effect2 applyEffectTo: gamepiece ofGamepieceCollection: #().
	self assert: gamepiece position equals: 0
]