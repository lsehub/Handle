Handle subclass: #AbstractMirrorHandle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ApplicationMirrorAPI'!

AbstractMirrorHandle subclass: #PrimitivesScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ApplicationMirrorAPI'!

!PrimitivesScope methodsFor: 'ProtoObject'!
'drawing' stamp: 'FernandoOlivero 1/25/2010 16:51'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 11/11/2009 20:15'!
= 0.
			1 to: basicSize do: [:i |
				(self basicAt: i) == nil
					ifFalse: [(counter := counter + 1) = anIndex ifTrue: [^self basicAt: i put: anObject]]]]].
	self error: 'access with an index out of bounds'! !

!PrimitivesScope methodsFor: 'ProtoObject'!
methodsFor: 'testing' stamp: 'cmm 9/13/2007 12:24'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 1/16/2010 20:57'!
lation for the sources file"
	
	| sf i p a a2 |
	sf := ExpandedSourceFileArray new.
	0 to: 16r1FFFFFFF by: 4093 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		i := sf fileIndexFromSourcePointer: a.
		self assert: i == 1.
		p := sf filePositionFromSourcePointer: a.
		self assert: p = e.
		a2 := sf sourcePointerFromFileIndex: 1 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r1000000 and: 16r1FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r3000000 and: 16r3FFFFFF)].

	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r5000000 and: 16r5FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 1/5/2010 15:59'!
(x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 1/5/2010 15:59'!
traLen.
		1 to: s size do: [ :i | s at: i put: (Character value: 200 atRandom)].
		msg := 'This is a test...',s.
		keys := self testKeySet.
		sig := self sign: msg privateKey: keys first dsa: dsa.
		"self inform: 'Signature created'."
		self timeDirect: [
			count timesRepeat: [
				(self verify: sig isSignatureOf: msg publicKey: keys last)
					ifFalse: [self error: 'ERROR!! Signature verification failed'].
			].
		] as: 'verify msgLen = ',msg size printString count: count
	].
! !

!PrimitivesScope methodsFor: 'ProtoObject'!
'FernandoOlivero 3/16/2010 00:35'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'alain.plantec 4/9/2009 09:56'!
getEnabledSel 
	^ self
		on: anObject
		list: getListSel
		selected: getSelectionSel
		changeSelected: setSelectionSel
		useIndex: useIndex
		addToList: addToListSel
		class: aClass
		getEnabled: getEnabledSel
		default: '' ! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 1/5/2010 15:59'!
:= Array new writeStream.
			rectList do:[:r|
				remaining nextPutAll:(r areasOutside: excluded)].
			rectList := remaining contents].
	].
	rectList do:[:r| self forceToScreen: r].
	regions ifNotNil:[
		"Have the drawers paint what is needed"
		regions do:[:drawerAndRect| (drawerAndRect at: 1) forceToScreen].
	].! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'alain.plantec 5/18/2009 15:54'!
x|
	src := self srcText.
	dst := self dstText.
	ctx := self contextClass.
	(self prettyPrint and: [ctx notNil])
		ifTrue: [src isEmpty ifFalse: [
					src := ctx prettyPrinterClass 
						format: src
						in: ctx
						notifying: nil].
				dst isEmpty ifFalse: [
					dst := ctx prettyPrinterClass 
						format: dst
						in: ctx
						notifying: nil]].	
	self srcMorph setText: src; font: self theme textFont.
	self dstMorph setText: dst; font: self theme textFont! !

!PrimitivesScope methodsFor: 'ProtoObject'!
'testing' stamp: 'nice 1/16/2010 20:55'! !

!PrimitivesScope methodsFor: 'ProtoObject'!
methodsFor: 'settings' stamp: 'AlainPlantec 12/11/2009 10:07'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'StephaneDucasse 4/24/2010 10:53'!
6.10' 
		'+0:01:02:55' 
		'+0:01:02:3') do: [:each | each asDuration printString = each]! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 3/16/2010 19:34'!
: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'ProtoObject'!
l: [self forwardDirection]
		ifNotNil: [self forwardDirection + self owner degreesOfFlex]! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 2/13/2010 01:54'!
rt // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'ProtoObject'!
ileArray methodsFor: 'sourcePointer conversion' stamp: 'dtl 12/26/2009 15:10'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'nice 1/16/2010 20:57'!
: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r5000000 and: 16r5FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !

!PrimitivesScope methodsFor: 'ProtoObject'!
ffChangeMorph methodsFor: 'actions' stamp: 'gvc 2/9/2010 13:17'! !

!PrimitivesScope methodsFor: 'ProtoObject' stamp: 'gvc 1/20/2010 11:58'!
tyle.! !


!PrimitivesScope methodsFor: 'Object'!
rph methodsFor: 'drawing' stamp: 'FernandoOlivero 1/21/2010 14:52'! !

!PrimitivesScope methodsFor: 'Object'!
file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'Object' stamp: 'nice 1/5/2010 15:59'!
st.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) 
		ifTrue: 
			[ pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10 ]
		ifFalse: [ pointSize := (ascent + descent) * 72 // 96 ].
	maxWidth := 0.
	minAscii := 2097152.
	strikeWidth := 0.
	maxAscii := 0.
	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.
	self 
		readCharactersInRangeFrom: start
		to: end
		totalNums: charsNum
		storeInto: chars.
	chars := chars asSortedCollection: [ :x :y | (x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'Object' stamp: 'nice 11/11/2009 20:34'!
lf startingAt: 1.
	^selection! !

!PrimitivesScope methodsFor: 'Object' stamp: 'FernandoOlivero 3/16/2010 00:55'!
editor mouseMove: evt index: (self characterIndexAtPoint: evt cursorPoint) ]! !

!PrimitivesScope methodsFor: 'Object' stamp: 'StephaneDucasse 5/13/2010 12:09'!
fPresent:ifAbsent:"
	
	"to move to the corresponding trait"
	| dict present absent |
	dict := Dictionary new.
	present := absent := false.
	dict at: #foo ifPresent: [:v| present := true] ifAbsent: [absent := true].
	self deny: present.
	self assert: absent.

	dict at: #foo put: #bar.
	present := absent := false.
	dict at: #foo ifPresent: [:v| present := true] ifAbsent: [absent := true].
	self assert: present.
	self deny: absent.

	present := absent := false.
	dict at: #foo ifPresent: [:v| present := true. nil] ifAbsent: [absent := true].
	self assert: present.
	self deny: absent.
! !

!PrimitivesScope methodsFor: 'Object' stamp: 'StephaneDucasse 4/24/2010 19:50'!
ion  days: 1 hours: 2 minutes: 3 seconds:4) seconds = (1*24*60*60+(2*60*60)+(3*60)+4).	! !

!PrimitivesScope methodsFor: 'Object' stamp: 'gvc 3/5/2010 12:43'!
initialExtent
	"Answer the initial extent for the receiver."

	^RealEstateAgent standardWindowExtent! !

!PrimitivesScope methodsFor: 'Object'!
h methodsFor: 'accessing' stamp: 'FernandoOlivero 3/16/2010 00:46'! !

!PrimitivesScope methodsFor: 'Object' stamp: 'jmv 11/5/2008 10:04'!
string := self string.
	"Empty strings have no lines at all. Think of something."
	string isEmpty ifTrue:[^{#(1 0 0)}].
	stringSize := string size.
	lines := OrderedCollection new: (string size // 15).
	index := 0.
	lineIndex := 0.
	string linesDo:[:line |
		lines addLast: (Array
			with: (index := index + 1)
			with: (lineIndex := lineIndex + 1)
			with: (index := index + line size min: stringSize))].
	"Special workaround for last line empty."
	string last == Character cr
	"lines last last < stringSize" ifTrue:[lines addLast:{stringSize +1. lineIndex+1. stringSize}].
	^lines! !

!PrimitivesScope methodsFor: 'Object' stamp: 'nice 3/16/2010 19:37'!
dex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !


!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'StephaneDucasse 3/23/2010 21:41'!
odel: self.
	windowSpec label: 'Change Sorter'.
	windowSpec children: OrderedCollection new.
	leftCngSorter buildWith: builder in: windowSpec rect: (0@0 extent: 0.5@1).
	rightCngSorter buildWith: builder in: windowSpec rect: (0.5@0 extent: 0.5@1).
	^builder build: windowSpec
! !

!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'nice 12/26/2009 01:32'!
single message by ImageSegment.prepareToBeSaved."

	^ self associationAt: aKey ifAbsent: [
		| existing |
		(Undeclared includesKey: aKey)
			ifTrue: 
				[existing := Undeclared associationAt: aKey.
				Undeclared removeKey: aKey.
				self add: existing]
			ifFalse: 
				[self add: aKey -> false]]! !

!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'FernandoOlivero 3/15/2010 23:59'!
s flag to the given value. "
	! !

!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'nice 1/5/2010 15:59'!
((properties at: #FONTBOUNDINGBOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) ifTrue: [
		pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].

	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"

	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'nice 3/16/2010 19:34'!
ght := line lineHeight.
	rightMargin := line rightMargin + offset x.
	lastIndex := line first.
	leftInRun <= 0 ifTrue: [ self setStopConditions ].
	leftMargin := (line leftMarginForAlignment: alignment) + offset x.
	destX := runX := leftMargin.
	fillBlt == nil ifFalse: 
		[ "Not right"
		fillBlt
			destX: line left
				destY: lineY
				width: line width left
				height: lineHeight;
			copyBits ].
	lastIndex := line first.
	leftInRun <= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'MidiPrimTester' stamp: 'nice 11/11/2009 17:19'!
ifTrue: [
			counter := 0.
			1 to: basicSize do: [:i |
				(dep := self basicAt: i) == nil
					ifFalse: [(counter := counter + 1) = anIndex ifTrue: [^dep]]]]].
	self error: 'access with an index out of bounds'! !


!PrimitivesScope methodsFor: 'BitBlt' stamp: 'cmm 9/12/2007 17:21'!
Directory name: name0 creationTime: creationTime modificationTime: modificationTime fileSize: fileSize 
	^ self new 
		setDirectory: aFileDirectoryOrServerDirectory
		name: name0
		creationTime: creationTime
		modificationTime: modificationTime
		fileSize: fileSize! !

!PrimitivesScope methodsFor: 'BitBlt'!
xamples' stamp: 'nice 1/5/2010 15:59'! !

!PrimitivesScope methodsFor: 'BitBlt' stamp: 'jmv 11/4/2008 23:42'!
r that's done the selection is still empty, then evaluate the returnBlock, which will typically consist of '[^ self]' in the caller -- check senders of this method to understand this."

	self selectLine.  "if current selection is an insertion point, then first select the entire line in which occurs before proceeding"
	self hasSelection ifFalse: [morph flash.  ^ returnBlock value]! !

!PrimitivesScope methodsFor: 'BitBlt' stamp: 'nice 1/16/2010 20:56'!
urceFileArray across the address range of
	StandardSourceFileArray, including the unused address space below 16r1000000"
	
	| ssf esf i1 i2 p1 p2 a1 a2 |
	ssf := StandardSourceFileArray new.
	esf := ExpandedSourceFileArray new.
	0 to: 16rFFFFFF by: 811 do: [:e |
		i1 := ssf fileIndexFromSourcePointer: e.
		i2 := esf fileIndexFromSourcePointer: e.
		self assert: i1 = i2.
		self assert: i1 = 0. "This is unused address space"
		p1 := ssf filePositionFromSourcePointer: e.
		p2 := esf filePositionFromSourcePointer: e.
		self assert: p1 = p2].
	16r4FFFFFF to: 16r4FFFFFF by: 811 do: [:e |
		i1 := ssf fileIndexFromSourcePointer: e.
		i2 := esf fileIndexFromSourcePointer: e.
		self assert: i1 = i2.
		p1 := ssf filePositionFromSourcePointer: e.
		p2 := esf filePositionFromSourcePointer: e.
		self assert: p1 = p2.
		a1 := ssf sourcePointerFromFileIndex: i1 andPosition: p1.
		a2 := esf sourcePointerFromFileIndex: i2 andPosition: p2.
		self assert: a1 = a2.
		self assert: a1= e]

! !

!PrimitivesScope methodsFor: 'BitBlt' stamp: 'StephaneDucasse 2/2/2010 21:55'!
icKey) 
					ifTrue: [Transcript show: 'SUCCESS: ',msg; cr.]
					ifFalse: [self error: 'ERROR!! Signature verification failed']]]! !

!PrimitivesScope methodsFor: 'BitBlt'!
or: 'accessing-selection' stamp: 'jmv 11/4/2008 23:43'! !


!PrimitivesScope methodsFor: 'WarpBlt' stamp: 'AlainPlantec 1/31/2010 17:01'!
en;
		setSelector: #fullScreen:;
		description: 'On platforms that support it, set full-screen mode' translated;
		default: false.
! !


!PrimitivesScope methodsFor: 'Number' stamp: 'dtl 12/26/2009 14:56'!
vation of file index for sources or changes file from source pointers"

	| sf |
	sf := ExpandedSourceFileArray new.
	"sources file mapping"
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r1000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r1000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r1FFFFFF).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3FFFFFF).

	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5FFFFFF).

	(16r1000000 to: 16r1FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	(16r3000000 to: 16r3FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	"changes file mapping"
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2FFFFFF).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4FFFFFF).

	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !


!PrimitivesScope methodsFor: 'Float'!
'! !

!PrimitivesScope methodsFor: 'Float'!
31/2010 14:46'! !

!PrimitivesScope methodsFor: 'Float' stamp: 'alain.plantec 4/8/2009 10:41'!
lf contentMorph ghostText: aText
! !

!PrimitivesScope methodsFor: 'Float'!
hodsFor: 'instance creation' stamp: 'nice 11/11/2009 17:24'! !

!PrimitivesScope methodsFor: 'Float'!
or: 'testing' stamp: 'nice 2/13/2010 02:25'! !

!PrimitivesScope methodsFor: 'Float'!
tamp: 'FernandoOlivero 3/20/2010 20:04'! !

!PrimitivesScope methodsFor: 'Float' stamp: 'yo 10/4/2002 20:43'!
ditionArray: (alignment = Justified ifTrue: [#paddedSpace]).

"
	alignment = Justified ifTrue: [
		stopConditions == DefaultStopConditions 
			ifTrue:[stopConditions := stopConditions copy].
		stopConditions at: Space asciiValue + 1 put: #paddedSpace]
"! !

!PrimitivesScope methodsFor: 'Float' stamp: 'lr 3/14/2010 21:13'!
elector
				ifTrue: [ :selector | 
					[ globalObj := globalObj perform: selector ]
						on: Error
						do: [ :ex | 
							ex messageText = 'key not found'
								ifTrue: [ ^ nil ].
							^ ex signal ] ] ].	"keep the Proxy if Project does not exist"
	constructorSelector ifNil: [ ^ globalObj ].
	Symbol
		hasInterned: constructorSelector
		ifTrue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'Float' stamp: 'nice 2/13/2010 01:55'!
f expected: 'a digit between 0 and 9'].! !


!PrimitivesScope methodsFor: 'Integer' stamp: 'AlainPlantec 12/16/2009 22:08'!
I themes that make use of different colors for Browser, MessageList etc..."

	^ Color paleBlue
! !

!PrimitivesScope methodsFor: 'Integer' stamp: 'gvc 3/6/2010 17:08'!
ogWindow]
		thenCollect: [:m | m bounds expandBy: 8].
	baseArea := RealEstateAgent maximumUsableArea insetBy: 8.
	searching := true.
	baseArea allAreasOutsideList: areas do: [:rect |
		searching ifTrue: [
			aSystemWindow extent <= (rect insetBy: 8) extent
				ifTrue: [foundRect := rect.
						searching := false]]].
	searching ifTrue: [foundRect := baseArea].
	aSystemWindow setWindowColor: self theme windowColor.
	aSystemWindow position: foundRect topLeft + 8.
	aSystemWindow openAsIs.
	^aSystemWindow! !

!PrimitivesScope methodsFor: 'Integer' stamp: 'nice 1/5/2010 15:59'!
with a different implementation"
	"Note: Secure random numbers are needed for key generation and message signing, but not for signature verification. There is no need to call initRandomFromUser if you are merely checking a signature."
	"DigitalSignatureAlgorithm writeExamplesToDisk"

	| file keyList dsa msgList |

	dsa := DigitalSignatureAlgorithm new.
	dsa initRandomFromUser.
	self inform: 'About to generate 5 key sets. Will take a while'.
	keyList := {self testKeySet},((1 to: 5) collect: [ :ignore | self generateKeySet]).
	msgList := {'This is a test...'. 'This is the second test period.'. 'And finally, a third message'}.
	file := FileStream newFileNamed: 'dsa.test.out'.
	[
		msgList do: [ :msg |
			keyList do: [ :keys | | sig |
				sig := self sign: msg privateKey: keys first dsa: dsa.
				(self verify: sig isSignatureOf: msg publicKey: keys last) ifTrue: [
					file
						nextChunkPut: sig;
						nextChunkPut: msg;
						nextChunkPut: keys last storeString.
				] ifFalse: [
					self error: 'ERROR!! Signature verification failed'
				].
			].
		].
	] ensure: [file close]
! !

!PrimitivesScope methodsFor: 'Integer' stamp: 'nice 3/16/2010 19:37'!
groundColor := aParagraph backgroundColor.
	aParagraph backgroundColor isTransparent 
		ifTrue: [ fillBlt := nil ]
		ifFalse: 
			[ fillBlt := bitBlt copy.	"Blt to fill spaces, tabs, margins"
			fillBlt
				sourceForm: nil;
				sourceOrigin: 0 @ 0.
			fillBlt fillColor: aParagraph backgroundColor ].
	rightMargin := aParagraph rightMarginForDisplay.
	lineY := aParagraph topAtLineIndex: linesInterval first.
	bitBlt destForm 
		deferUpdatesIn: visibleRectangle
		while: 
			[ linesInterval do: 
				[ :lineIndex |
				| string stopCondition startIndex runLength lastPos | 
				line := aParagraph lines at: lineIndex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'Integer' stamp: 'pavel.krivanek 3/2/2010 21:25'!
they want (e.g.
	 Diffing pretty printers that are simply formatting text).  As this breaks
	 compilation it should only be used by clients that want to discard the result
	 of the compilation.  To squash the warning use e.g.
		[Compiler format: code in: class notifying: nil decorated: false]
			on: UndeclaredVariableWarning
			do: [:ex| ex resume: false]"
	sym := name asSymbol.
	^(UndeclaredVariableWarning new name: name selector: selector class: class) signal
		ifTrue:
			[Undeclared at: sym put: nil.
			self global: (Undeclared associationAt: sym) name: sym]
		ifFalse:
			[self global: (Association key: sym) name: sym]! !

!PrimitivesScope methodsFor: 'Integer'!
! !

!PrimitivesScope methodsFor: 'Integer'!
m 8/10/2007 12:25'! !


!PrimitivesScope methodsFor: 'SmallInteger' stamp: 'dtl 12/26/2009 15:03'!
False: [anInteger >= 16r1000000
			ifTrue: [^2 "changes file"]
			ifFalse: [^0 "compatibility with StandardSourceFileArray"]]! !


!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'MarcusDenker 12/11/2009 23:59'!
Event position.
	(topRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToTop].
	(bottomRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToBottom].
	(leftRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToLeft].
	(rightRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToRight].
	self beFloating! !

!PrimitivesScope methodsFor: 'LargePositiveInteger'!
ss methodsFor: 'instance creation' stamp: 'nice 11/11/2009 17:30'! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'jmv 11/4/2008 23:36'!
-- match to the left"
					stop := here - 1.
					direction := -1.
					closeDelimiter := leftDelimiters at: match]
				ifFalse: ["no delimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'jmv 11/4/2008 23:14'!
Mark: mark point: point
	"Select the designated characters, inclusive.  Make no visual changes."

	self markIndex: mark; pointIndex: point + 1! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'brp 1/9/2004 06:28'!
assert: -1 day = (Duration days: -1);
		assert: 1 hours = (Duration hours: 1);
		assert: -1 hour = (Duration hours: -1);
		assert: 1 minute = (Duration seconds: 60);
		assert: -1 minute = (Duration seconds: -60);
		assert: 1 second = (Duration seconds: 1);
		assert: -1 second = (Duration seconds: -1);
		assert: 1 milliSecond = (Duration milliSeconds: 1);
		assert: -1 milliSecond = (Duration milliSeconds: -1);
		assert: 1 nanoSecond = (Duration nanoSeconds: 1);
		assert: -1 nanoSecond = (Duration nanoSeconds: -1)
		! !

!PrimitivesScope methodsFor: 'LargePositiveInteger'!
lassified' stamp: 'nice 1/5/2010 15:59'! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'nice 1/16/2010 20:55'!
000000 by: 4093 do: [:e |
		i := sf fileIndexFromSourcePointer: e.
		p := sf filePositionFromSourcePointer: e.
		a := sf sourcePointerFromFileIndex: i andPosition: p.
		self assert: a = e]
! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'jmv 9/2/2009 12:38'!
f asString.
	^false! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'nice 3/5/2010 22:31'!
move the window from 210 @ 450 to 300 @ 300
		d) change the window title
		e) change the window size from 400 @ 400 to 600 @ 400
		f) wait 4 seconds so you can see the result
		g) close the window via the garbage collecttor finalizing it"
	self open.
	Display displayOn: self.
	self forceToScreen.
	Display displayOn: self at: -100 @ -200.
	self forceToScreen: (100 @ 100 extent: 200 @ 200).
	self windowPosition: 300 @ 300.
	self windowTitle: 'YooHoo!! New title'.
	self windowSize: 600 @ 400.
	(Delay forSeconds: 4) wait.! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'brp 1/21/2004 18:36'!
self assert: aDuration \\ aDuration = 
		(Duration days: 0 hours: 0 minutes: 0 seconds: 0 nanoSeconds: 0). 
	self assert: aDuration \\ 2 = 
		(Duration days: 0 hours: 0 minutes: 0 seconds: 0 nanoSeconds: 1).
	

! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'dtl 12/26/2009 14:56'!
|
	sf := ExpandedSourceFileArray new.
	"sources file"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r1000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r1000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r1FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r3000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r3000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r3FFFFFF).
	"changes file"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r2000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r2000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r2FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r4000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r4000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r4FFFFFF).
	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'LargePositiveInteger'!
entify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'nice 1/5/2010 15:59'!
e.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'AlainPlantec 1/31/2010 14:46'!
: #mustCheckForSlips withBlock: [ChangeSet mustCheckForSlips: true].
! !

!PrimitivesScope methodsFor: 'LargePositiveInteger'!
xpandedSourceFileArrayTest commentStamp: 'dtl 12/22/2009 23:10' prior: 0! !

!PrimitivesScope methodsFor: 'LargePositiveInteger'!
/11/2009 17:29'! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'StephaneDucasse 5/1/2010 16:13'!
whileTrue: [nanos nextPut: aStream next].
		
	^ self 
		days: days 
		hours: hours 
		minutes: minutes 
		seconds: seconds 
		nanoSeconds: (nanosBuffer asInteger sign: sign)! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'jmv 11/4/2008 23:36'!
ifFalse: ["if at beginning or end, select entire string"
			^self selectFrom: 1 to: string size].
	leftDelimiters := '([{<''"
'.
	rightDelimiters := ')]}>''"
'.
	openDelimiter := string at: here - 1.
	match := leftDelimiters indexOf: openDelimiter.
	match > 0
		ifTrue: 
			["delimiter is on left -- match to the right"
			start := here.
			direction := 1.
			here := here - 1.
			closeDelimiter := rightDelimiters at: match]
		ifFalse: 
			[openDelimiter := string at: here.
			match := rightDelimiters indexOf: openDelimiter.
			match > 0
				ifTrue: 
					["delimiter is on right -- match to the left"
					stop := here - 1.
					direction := -1.
					closeDelimiter := leftDelimiters at: match]
				ifFalse: ["no delimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'LargePositiveInteger' stamp: 'nice 1/16/2010 20:55'!
FileIndex: i andPosition: p.
		self assert: a = e]
! !


!PrimitivesScope methodsFor: 'LargeNegativeInteger' stamp: 'AlainPlantec 1/31/2010 16:36'!
eSuffix
		self loadSetting: #userStylePackageNameSuffix withBlock: [SettingBrowser userStylePackageNameSuffix: ''].
! !


!PrimitivesScope methodsFor: 'FileList' stamp: 'jmv 9/2/2009 13:18'!
: forward specialBlock: specialBlock event: aKeyboardEvent
	"Private - Move cursor.
	directionBlock is a one argument Block that computes the new Position from a given one.
	specialBlock is a one argumentBlock that computes the new position from a given one under the alternate semantics.
	Note that directionBlock always is evaluated first."
	| shift indices newPosition |
	shift := aKeyboardEvent shiftPressed.
	indices := self setIndices: shift forward: forward.
	newPosition := directionBlock value: (indices at: #moving).
	(aKeyboardEvent commandKeyPressed or: [ aKeyboardEvent controlKeyPressed ])
		ifTrue: [newPosition := specialBlock value: newPosition].
	shift
		ifTrue: [self selectMark: (indices at: #fixed) point: newPosition - 1]
		ifFalse: [self selectAt: newPosition]! !


!PrimitivesScope methodsFor: 'JPEGReadWriter'!
methodsFor: 'initialization' stamp: 'StephaneDucasse 3/23/2010 21:41'! !

!PrimitivesScope methodsFor: 'JPEGReadWriter' stamp: 'AlainPlantec 4/15/2010 11:41'!
ifTrue:[
					indices at: #moving put: self stopIndex.
					indices at: #fixed put: self startIndex.
				] ifFalse: [
					indices at: #moving put: self startIndex.
					indices at: #fixed put: self stopIndex.
				]
		].
	^indices! !

!PrimitivesScope methodsFor: 'JPEGReadWriter' stamp: 'gvc 3/5/2010 12:43'!
end: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'JPEGReadWriter' stamp: 'nice 1/16/2010 20:57'!
1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !


!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'StephaneDucasse 4/24/2010 10:53'!
:00:00:00' 
		'0:00:00:00.000000001' 
		'0:00:00:00.999999999' 
		'0:00:00:00.100000000' 
		'0:00:00:00.10' 
		'0:00:00:00.1' 
		'0:00:00:01' 
		'0:12:45:45' 
		'1:00:00:00' 
		'365:00:00:00' 
		'-7:09:12:06.10' 
		'+0:01:02:55' 
		'+0:01:02:3') do: [:each | each asDuration printString = each]! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'nice 3/5/2010 22:31'!
4 seconds so you can see the result
		g) close the window via the garbage collecttor finalizing it"
	self open.
	Display displayOn: self.
	self forceToScreen.
	Display displayOn: self at: -100 @ -200.
	self forceToScreen: (100 @ 100 extent: 200 @ 200).
	self windowPosition: 300 @ 300.
	self windowTitle: 'YooHoo!! New title'.
	self windowSize: 600 @ 400.
	(Delay forSeconds: 4) wait.! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'nice 12/26/2009 01:32'!
ndeclared removeKey: aKey.
				self add: existing]
			ifFalse: 
				[self add: aKey -> false]]! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'nice 1/5/2010 15:59'!
ng to prevent repeated errors"
	regions := extraRegions.
	extraRegions := nil.
	regions ifNotNil:[
		"exclude extra regions"
		regions do:[:drawerAndRect| | excluded remaining |
			excluded := drawerAndRect at: 2.
			remaining := Array new writeStream.
			rectList do:[:r|
				remaining nextPutAll:(r areasOutside: excluded)].
			rectList := remaining contents].
	].
	rectList do:[:r| self forceToScreen: r].
	regions ifNotNil:[
		"Have the drawers paint what is needed"
		regions do:[:drawerAndRect| (drawerAndRect at: 1) forceToScreen].
	].! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'nice 1/5/2010 15:59'!
at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter'!
5/2003 14:30'! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'FernandoOlivero 3/16/2010 00:46'!
ts and end editing"
	announcer announce:( AcceptedContentsAnnouncement on: self ).
	! !

!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter' stamp: 'FernandoOlivero 1/21/2010 12:22'!
elf changed! !


!PrimitivesScope methodsFor: 'AsyncFile'!
degrees := delta degrees + 90.0.
	self forwardDirection: (degrees \\ 360) rounded.
! !

!PrimitivesScope methodsFor: 'AsyncFile' stamp: 'gvc 2/9/2010 13:10'!
l! !

!PrimitivesScope methodsFor: 'AsyncFile' stamp: 'gvc 9/22/2009 11:16'!
r canBeMaximized]
		ifFalse: [false]! !

!PrimitivesScope methodsFor: 'AsyncFile'!
dentsArray methodsFor: 'accessing' stamp: 'nice 11/11/2009 20:15'! !

!PrimitivesScope methodsFor: 'AsyncFile' stamp: 'jmv 11/4/2008 23:36'!
har := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !


!PrimitivesScope methodsFor: 'ProcessorScheduler' stamp: 'gvc 2/10/2010 13:31'!
MapMorph
	"Answer a new map morph."

	^(DiffMapMorph new
		hResizing: #shrinkWrap;
		vResizing: #spaceFill;
		extent: 20@4;
		minWidth: 20;
		borderStyle: (BorderStyle inset width: 1))
			when: #mapClicked
			send: #mapClicked:
			to: self! !


!PrimitivesScope methodsFor: 'WordArray' stamp: 'StephaneDucasse 12/25/2009 12:12'!
the receiver's associations."
	"Suggested by l. Uzonyi"
	
	^Array new: self size streamContents: [ :stream |
		self associationsDo: [ :each | stream nextPut: each ] ]! !

!PrimitivesScope methodsFor: 'WordArray'!
et unclassified' stamp: 'FernandoOlivero 3/16/2010 00:14'! !

!PrimitivesScope methodsFor: 'WordArray' stamp: 'dtl 12/26/2009 15:10'!
hi := anInteger // 33554432.
	lo := anInteger \\ 16777216.
	((anInteger bitAnd: 16777216) ~= 0
			or: [anInteger < 16777216 "compatibility with StandardSourceFileArray"])
		ifTrue: [^ hi * 16777216 + lo"sources file"]
		ifFalse: [^ hi - 1 * 16777216 + lo"changes file"]! !

!PrimitivesScope methodsFor: 'WordArray' stamp: 'nice 11/11/2009 20:36'!
self basicSize do:[:i|
		(dep := self basicAt: i) ifNotNil:[aBlock value: dep]].! !

!PrimitivesScope methodsFor: 'WordArray' stamp: 'FernandoOlivero 3/20/2010 20:05'!
lf isReadOnly not ]! !

!PrimitivesScope methodsFor: 'WordArray'!
hodsFor: 'instance creation' stamp: 'nice 11/11/2009 17:29'! !

!PrimitivesScope methodsFor: 'WordArray' stamp: 'FernandoOlivero 3/21/2010 15:12'!
].
	(k = 28 and: [ editor isAtStart ]) ifTrue: [ ^super keyStroke: aKeyboardEvent ].
	(k = 29 and: [ editor isAtEnd ]) ifTrue: [ ^super keyStroke: aKeyboardEvent ].
	self handleInteraction: [ editor processKeyStroke: aKeyboardEvent ].
	self updateFromContents .! !

!PrimitivesScope methodsFor: 'WordArray' stamp: 'FernandoOlivero 3/16/2010 00:54'!
^ self ].
	evt yellowButtonPressed ifTrue: [ ^ self yellowButtonActivity: evt shiftPressed].
	evt hand newKeyboardFocus: self .
	self handleInteraction: [editor mouseDown: evt]
		! !


!PrimitivesScope methodsFor: 'Array'!
ource pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'Array' stamp: 'StephaneDucasse 3/17/2010 20:55'!
romString: 
 			Time millisecondClockValue printString, 
 			Date today printString, 
 			Smalltalk platformName printString].! !

!PrimitivesScope methodsFor: 'Array' stamp: 'nice 2/13/2010 01:54'!
onent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'Array' stamp: 'jmv 11/4/2008 23:10'!
- 1! !

!PrimitivesScope methodsFor: 'Array' stamp: 'nice 1/16/2010 20:57'!
ileIndex: 1 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r1000000 and: 16r1FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r3000000 and: 16r3FFFFFF)].

	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r5000000 and: 16r5FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !


!PrimitivesScope methodsFor: 'Bitmap'!
! !

!PrimitivesScope methodsFor: 'Bitmap'!
newStackIn: self
		for: #()! !

!PrimitivesScope methodsFor: 'Bitmap'!
on methodsFor: 'operations' stamp: 'brp 9/25/2003 15:42'! !

!PrimitivesScope methodsFor: 'Bitmap' stamp: 'nice 3/16/2010 19:37'!
destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !


!PrimitivesScope methodsFor: 'FloatArray'!
10 00:55'! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'nice 1/5/2010 15:59'!
x := (allEnabledSiblingItems indexOf: selectedItem ifAbsent: [0 + (anInteger negative ifTrue: [1] ifFalse: [0])]) + anInteger.
	allEnabledSiblingItems do: "Ensure finite"
		[:unused | | m | m := allEnabledSiblingItems atWrap: index.
		((m isKindOf: MenuItemMorph) and: [m isEnabled]) ifTrue:
			[m owner = self owner ifFalse: [
				anEvent hand newKeyboardFocus: m owner].
				^m owner selectItem: m event: anEvent].
		"Keep looking for an enabled item"
		index := index + anInteger sign].
	^self selectItem: nil event: anEvent! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'nice 2/13/2010 02:25'!
'1.') = 1.
	self assert: (ExtendedNumberParser parse: '1.') isFloat.
	
	self assert: (ExtendedNumberParser parse: '3.e2') = 300.
	self assert: (ExtendedNumberParser parse: '3.e2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4.e2') = -400.
	self assert: (ExtendedNumberParser parse: '-4.e2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+5.e2') = 500.
	self assert: (ExtendedNumberParser parse: '+5.e2') isFloat.

	self assert: (ExtendedNumberParser parse: '+6.e+2') = 600.
	self assert: (ExtendedNumberParser parse: '+6.e+2') isFloat.

	self assert: (ExtendedNumberParser parse: '-7.e+2') = -700.
	self assert: (ExtendedNumberParser parse: '-7.e+2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') = (1/4).
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') = (-1/16).
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') isFloat.! !

!PrimitivesScope methodsFor: 'FloatArray'!
g' stamp: 'FernandoOlivero 3/16/2010 00:48'! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'nice 2/13/2010 02:23'!
e-+1') = 2.
	self assert: (ExtendedNumberParser parse: '2e-Z') = 2.
	self assert: (ExtendedNumberParser parse: '+2e-W') = 2.
	self assert: (ExtendedNumberParser parse: '-2e-X') = -2.
	
	self assert: (ExtendedNumberParser parse: '3e+') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-1') = 3.
	self assert: (ExtendedNumberParser parse: '+3e+W') = 3.
	self assert: (ExtendedNumberParser parse: '-3e+Z') = -3.! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'FernandoOlivero 3/20/2010 20:08'!
cus not ifTrue:[^ Color red muchLighter mixed: 0.7 with: Color veryVeryLightGray    ].
	self hasKeyboardFocus
		ifTrue:[ ^ self color   ] 
		ifFalse:[ ^ self color muchDarker   ].! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'pmm 3/13/2010 11:22'!
m j code | 
		code := array at: 2.
		"code printStringHex printString displayAt: 0@0."
		code > currentRange last ifTrue: 
			[ 
			[ rangeStream atEnd not and: 
				[ currentRange := rangeStream next.
				currentRange last < code ] ] whileTrue.
			rangeStream atEnd ifTrue: 
				[ newChars addAll: chars.
				^ newChars ] ].
		(code 
			between: currentRange first
			and: currentRange last) ifTrue: 
			[ form := array at: 1.
			form ifNotNil: 
				[ j := array at: 2.
				u := table at: (j // 256 - 33) * 94 + (j \\ 256 - 33) + 1.
				u ~= -1 ifTrue: 
					[ array 
						at: 2
						put: u.
					newChars add: array.
					additionalRange do: 
						[ :e | | newArray | 
						e first = (array at: 2) ifTrue: 
							[ newArray := array shallowCopy.
							newArray 
								at: 2
								put: e second.
							newChars add: newArray ] ] ] ] ] ].
	self error: 'should not reach here'! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'brp 1/21/2004 18:37'!
0).
	self assert:  (aDuration truncateTo: (Duration hours: 1)) =
	               (Duration days: 1 hours: 2 minutes: 0 seconds: 0 nanoSeconds: 0).	
	self assert:  (aDuration truncateTo: (Duration minutes: 1)) =
	               (Duration days: 1 hours: 2 minutes: 3 seconds: 0 nanoSeconds: 0).! !

!PrimitivesScope methodsFor: 'FloatArray' stamp: 'AlainPlantec 12/11/2009 10:09'!
elf].
	self showWarning 
		ifTrue: [Transcript nextPutAll: self messageText; cr; flush].
	self raiseWarning 
		ifTrue: [super defaultAction]! !


!PrimitivesScope methodsFor: 'ShortRunArray'!
hodsFor: 'accessing' stamp: 'nice 11/11/2009 19:20'! !


!PrimitivesScope methodsFor: 'ByteArray' stamp: 'nice 1/5/2010 15:59'!
bx strikeWidth minAscii maxAscii maxWidth |
	form := encoding := bbx := nil.
	self initialize.
	self readAttributes.
	height := Integer readFromString: ((properties at: #FONTBOUNDINGBOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) ifTrue: [
		pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].

	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"

	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'CompiledMethod' stamp: 'lr 3/14/2010 21:13'!
].
	constructorSelector == #yourself
		ifFalse: [ ^ nil ].
	^ Smalltalk globals at: globalObjectName ifAbsent: [ nil ]! !

!PrimitivesScope methodsFor: 'CompiledMethod' stamp: 'brp 1/21/2004 18:36'!
nds: 5 ! !


!PrimitivesScope methodsFor: 'UUID' stamp: 'StephaneDucasse 3/23/2010 20:09'!
ze
	"DeprecationPreferences initialize"
	! !


!PrimitivesScope methodsFor: 'String' stamp: 'MarcusDenker 12/11/2009 07:38'!
self useSelectionIndex
				ifTrue: [m perform: s with: anInteger]
				ifFalse: [m perform: s with: self selectedItem]]]! !

!PrimitivesScope methodsFor: 'String'!
For: 'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !


!PrimitivesScope methodsFor: 'ByteString'!
hodsFor: 'testing' stamp: 'nice 2/13/2010 02:25'! !

!PrimitivesScope methodsFor: 'ByteString' stamp: 'nice 1/16/2010 20:56'!
.
		self assert: (a between: 16r2000000 and: 16r2FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r4000000 and: 16r4FFFFFF)].
	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r6000000 and: 16r6FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r8000000 and: 16r8FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rA000000 and: 16rAFFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rC000000 and: 16rCFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !


!PrimitivesScope methodsFor: 'WideString' stamp: 'nice 3/16/2010 19:37'!
t to scan in the current run;
		when 0, it is time to call 'self setStopConditions'"
	| leftInRun |
	morphicOffset := 0 @ 0.
	leftInRun := 0.
	self 
		initializeFromParagraph: aParagraph
		clippedBy: visibleRectangle.
	ignoreColorChanges := false.
	paragraph := aParagraph.
	foregroundColor := paragraphColor := aParagraph foregroundColor.
	backgroundColor := aParagraph backgroundColor.
	aParagraph backgroundColor isTransparent 
		ifTrue: [ fillBlt := nil ]
		ifFalse: 
			[ fillBlt := bitBlt copy.	"Blt to fill spaces, tabs, margins"
			fillBlt
				sourceForm: nil;
				sourceOrigin: 0 @ 0.
			fillBlt fillColor: aParagraph backgroundColor ].
	rightMargin := aParagraph rightMarginForDisplay.
	lineY := aParagraph topAtLineIndex: linesInterval first.
	bitBlt destForm 
		deferUpdatesIn: visibleRectangle
		while: 
			[ linesInterval do: 
				[ :lineIndex |
				| string stopCondition startIndex runLength lastPos | 
				line := aParagraph lines at: lineIndex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'WideString' stamp: 'nice 2/13/2010 02:23'!
1.
	
	self assert: (ExtendedNumberParser parse: '2e-') = 2.
	self assert: (ExtendedNumberParser parse: '2e--1') = 2.
	self assert: (ExtendedNumberParser parse: '2e-+1') = 2.
	self assert: (ExtendedNumberParser parse: '2e-Z') = 2.
	self assert: (ExtendedNumberParser parse: '+2e-W') = 2.
	self assert: (ExtendedNumberParser parse: '-2e-X') = -2.
	
	self assert: (ExtendedNumberParser parse: '3e+') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-1') = 3.
	self assert: (ExtendedNumberParser parse: '+3e+W') = 3.
	self assert: (ExtendedNumberParser parse: '-3e+Z') = -3.! !


!PrimitivesScope methodsFor: 'ByteSymbol' stamp: 'dtl 12/26/2009 14:56'!
ilePositionFromSourcePointer: 16r1000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r1FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r3000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r3000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r3FFFFFF).
	"changes file"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r2000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r2000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r2FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r4000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r4000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r4FFFFFF).
	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'ByteSymbol'!
o rotate,
	then wrap it in one and return it.
	Polygons, eg, may override to do nothing."

	^ self addFlexShell! !


!PrimitivesScope methodsFor: 'WideSymbol' stamp: 'nice 10/5/2009 10:16'!
n add: each copy ] ].
	^newCollection! !

!PrimitivesScope methodsFor: 'WideSymbol' stamp: 'AlainPlantec 12/21/2009 23:12'!
or
	"Answer the color used for thew text selection."

	^self theme settings selectionColor  alpha: 0.5! !


!PrimitivesScope methodsFor: 'SoundBuffer' stamp: 'AlainPlantec 1/7/2010 22:04'!
- set the default parameter using the current theme settings as the inspiration source"
	self
		setColor: self theme settings derivedMenuColor
		borderWidth: self theme settings menuBorderWidth
		borderColor: self theme settings menuBorderColor! !


!PrimitivesScope methodsFor: 'Semaphore' stamp: 'gvc 3/5/2010 12:43'!
ph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'Semaphore' stamp: 'AlainPlantec 4/15/2010 11:41'!
ionsMayShrink"])
		ifTrue: [
			indices at: #moving put: self pointIndex.
			indices at: #fixed put: self markIndex
		] ifFalse: [
			forward
				ifTrue:[
					indices at: #moving put: self stopIndex.
					indices at: #fixed put: self startIndex.
				] ifFalse: [
					indices at: #moving put: self startIndex.
					indices at: #fixed put: self stopIndex.
				]
		].
	^indices! !


!PrimitivesScope methodsFor: 'DependentsArray' stamp: 'gvc 3/6/2010 17:08'!
SystemWindow setWindowColor: self theme windowColor.
	aSystemWindow position: foundRect topLeft + 8.
	aSystemWindow openAsIs.
	^aSystemWindow! !


!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'StephaneDucasse 4/28/2010 22:16'!
asMilliSeconds = 1.
	self assert: (Duration nanoSeconds: 1000000)  asMilliSeconds = 1.
	self assert: aDuration   asMilliSeconds = 93784000.
	self assert: (Duration milliSeconds: 3775) asSeconds = 3.
	self assert: (Duration milliSeconds: 3775) nanoSeconds = 775000000.
	self assert: (Duration milliSeconds: -3775) asSeconds = -3.
	self assert: (Duration milliSeconds: -3775) nanoSeconds = -775000000! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
ace should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'cmm 9/27/2007 11:49'!
f me in targetDirectory.  targetDirectory can be a FileDirectory, ServerDirectory or a DirectoryEntryDirectory.  If a file with my name already exists in targetDirectory, signal a FileExistsException."
	^ targetDirectory copyHere: self! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 2/13/2010 00:57'!
s stage, sign integerPart and a decimal point have been read.
	try and form a number with a fractionPart"
	
	| numberOfNonZeroFractionDigits numberOfTrailingZeroInFractionPart mantissa value |
	fractionPart := self nextUnsignedIntegerOrNilBase: base.
	fractionPart
		ifNil: [
			"No fractionPart found, but can be a 1.e2 syntax"
			fractionPart := 0.
			numberOfNonZeroFractionDigits := 0.
			numberOfTrailingZeroInFractionPart := 0]
		ifNotNil: [.
			numberOfNonZeroFractionDigits := lastNonZero.
			numberOfTrailingZeroInFractionPart := nDigits - lastNonZero].
	self readExponent
		ifFalse: [self readScale
				ifTrue: [^self makeScaledDecimalWithNumberOfNonZeroFractionDigits: numberOfNonZeroFractionDigits
					andNumberOfTrailingZeroInFractionPart: numberOfTrailingZeroInFractionPart]].

	fractionPart isZero
		ifTrue: [mantissa := integerPart
						// (base raisedToInteger: numberOfTrailingZeroInIntegerPart).
			exponent := exponent + numberOfTrailingZeroInIntegerPart]
		ifFalse: [mantissa := integerPart
						* (base raisedToInteger: numberOfNonZeroFractionDigits) + (fractionPart // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 1/5/2010 15:59'!
:= array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
oo was not good. Use Bar>>newFoo instead.'
! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
dsFor: 'tests' stamp: 'brp 9/25/2003 14:57'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'brp 1/9/2004 06:28'!
e = (Duration seconds: 60);
		assert: -1 minute = (Duration seconds: -60);
		assert: 1 second = (Duration seconds: 1);
		assert: -1 second = (Duration seconds: -1);
		assert: 1 milliSecond = (Duration milliSeconds: 1);
		assert: -1 milliSecond = (Duration milliSeconds: -1);
		assert: 1 nanoSecond = (Duration nanoSeconds: 1);
		assert: -1 nanoSecond = (Duration nanoSeconds: -1)
		! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'alain.plantec 10/20/2009 12:41'!
tSel := aSelector! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 2/13/2010 00:57'!
[mantissa := integerPart
						* (base raisedToInteger: numberOfNonZeroFractionDigits) + (fractionPart // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'pmm 3/13/2010 11:22'!
ifTrue: 
				[ newChars addAll: chars.
				^ newChars ] ].
		(code 
			between: currentRange first
			and: currentRange last) ifTrue: 
			[ form := array at: 1.
			form ifNotNil: 
				[ j := array at: 2.
				u := table at: (j // 256 - 33) * 94 + (j \\ 256 - 33) + 1.
				u ~= -1 ifTrue: 
					[ array 
						at: 2
						put: u.
					newChars add: array.
					additionalRange do: 
						[ :e | | newArray | 
						e first = (array at: 2) ifTrue: 
							[ newArray := array shallowCopy.
							newArray 
								at: 2
								put: e second.
							newChars add: newArray ] ] ] ] ] ].
	self error: 'should not reach here'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'ul 9/22/2009 04:51'!
original and the copy"

	array := array collect: [ :association |
		association ifNotNil: [ association copy ] ]! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'jmv 11/4/2008 23:36'!
lt of double-clicking."

	| openDelimiter closeDelimiter direction match level leftDelimiters rightDelimiters
	string here hereChar start stop |
	string := self string.
	here := self pointIndex.
	(here between: 2 and: string size)
		ifFalse: ["if at beginning or end, select entire string"
			^self selectFrom: 1 to: string size].
	leftDelimiters := '([{<''"
'.
	rightDelimiters := ')]}>''"
'.
	openDelimiter := string at: here - 1.
	match := leftDelimiters indexOf: openDelimiter.
	match > 0
		ifTrue: 
			["delimiter is on left -- match to the right"
			start := here.
			direction := 1.
			here := here - 1.
			closeDelimiter := rightDelimiters at: match]
		ifFalse: 
			[openDelimiter := string at: here.
			match := rightDelimiters indexOf: openDelimiter.
			match > 0
				ifTrue: 
					["delimiter is on right -- match to the left"
					stop := here - 1.
					direction := -1.
					closeDelimiter := leftDelimiters at: match]
				ifFalse: ["no delimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 1/5/2010 15:59'!
.
	(properties includesKey: 'POINT_SIZE' asSymbol) ifTrue: [
		pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].

	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"

	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 1/5/2010 15:59'!
ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
morphs which are using myself"! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 11/11/2009 17:18'!
|
		(dep := self basicAt: i) ifNotNil: [aBlock value: dep]]! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'brp 1/21/2004 18:38'!
assert: ((5 minutes + 37 seconds) roundTo: (2 minutes)) = (6 minutes).
	
	self assert:  (aDuration roundTo: (Duration days: 1)) =
	               (Duration days: 1 hours: 0 minutes: 0 seconds: 0 nanoSeconds: 0).
	self assert:  (aDuration roundTo: (Duration hours: 1)) =
	               (Duration days: 1 hours: 2 minutes: 0 seconds: 0 nanoSeconds: 0).	
	self assert:  (aDuration roundTo: (Duration minutes: 1)) =
	               (Duration days: 1 hours: 2 minutes: 3 seconds: 0 nanoSeconds: 0).! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'StephaneDucasse 5/13/2010 12:09'!
:= false.
	dict at: #foo ifPresent: [:v| present := true. nil] ifAbsent: [absent := true].
	self assert: present.
	self deny: absent.
! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'MarcusDenker 12/11/2009 07:38'!
Show: self bounds]]
		ifFalse: [self selectItem: nil event: nil]! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
hodsFor: 'enumerating' stamp: 'TristanBourgois 5/10/2010 10:42'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'stephaneducasse 2/4/2006 20:32'!
ze
	files := Array new: 2.
	files at: 1 put: (SourceFiles at: 1).
	files at: 2 put: (SourceFiles at: 2)! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'dtl 12/26/2009 14:56'!
assert: 1 = (sf fileIndexFromSourcePointer: 16r1000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r1000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r1FFFFFF).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3FFFFFF).

	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5FFFFFF).

	(16r1000000 to: 16r1FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	(16r3000000 to: 16r3FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	"changes file mapping"
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2FFFFFF).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4FFFFFF).

	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 3/16/2010 19:37'!
Height.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
and 16r3000000 through 16r3FFFFFF, and positions in the changes file to address range 16r2000000 through 16r2FFFFFF and 16r4000000 through 16r4FFFFFF. This permits a maximum file size of 16r2000000 (32MB) for both the sources file and the changes file. 

ExpandedSourceFileArray extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
ce 12/18/2009 11:05'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 1/5/2010 15:59'!
.
	Answer nil if none.
	Disable non-matching items and enable matching items."

	| firstMatch|
	self items reverseDo: [:item | | match |
		match := aString isEmpty or: [item contents asString asLowercase beginsWith: aString].
		item isEnabled: match.
		(match and: [firstMatch isNil]) ifTrue: [firstMatch := item]].
	^firstMatch! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'jmv 9/2/2009 12:38'!
ardEvent 
	"Cut out the current text selection."

	self cut.
	^true! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
arSet class methodsFor: 'class methods' stamp: 'nice 3/6/2010 14:19'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'jmv 9/2/2009 12:38'!
96 sw"

	self closeTypeIn.
	self selectFrom: 1 to: self string size.
	^ true! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'AlainPlantec 1/31/2010 14:46'!
lock: [Deprecation raiseWarning: false].
! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'dtl 12/26/2009 14:56'!
ionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
rical>' prior: 0! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'nice 3/16/2010 19:37'!
leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
mp: 'jmv 9/2/2009 12:37'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'FernandoOlivero 1/21/2010 14:12'!
f margin * 2 + font height .
	self extent: bounds width @ fittedHeight! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
nPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'pmm 3/13/2010 11:22'!
rentRange := rangeStream next.
	newChars := PluggableSet new.
	newChars hashBlock: [ :elem | (elem at: 2) hash ].
	newChars equalBlock: [ :a :b | (a at: 2) = (b at: 2) ].
	other readChars do: 
		[ :array | | u form j code | 
		code := array at: 2.
		"code printStringHex printString displayAt: 0@0."
		code > currentRange last ifTrue: 
			[ 
			[ rangeStream atEnd not and: 
				[ currentRange := rangeStream next.
				currentRange last < code ] ] whileTrue.
			rangeStream atEnd ifTrue: 
				[ newChars addAll: chars.
				^ newChars ] ].
		(code 
			between: currentRange first
			and: currentRange last) ifTrue: 
			[ form := array at: 1.
			form ifNotNil: 
				[ j := array at: 2.
				u := table at: (j // 256 - 33) * 94 + (j \\ 256 - 33) + 1.
				u ~= -1 ifTrue: 
					[ array 
						at: 2
						put: u.
					newChars add: array.
					additionalRange do: 
						[ :e | | newArray | 
						e first = (array at: 2) ifTrue: 
							[ newArray := array shallowCopy.
							newArray 
								at: 2
								put: e second.
							newChars add: newArray ] ] ] ] ] ].
	self error: 'should not reach here'! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'BalloonEngine' stamp: 'MarcusDenker 12/11/2009 23:58'!
ct the receiver to adhere to the given edge.  
	 
	Options: #left #top #right #bottom or #none"
	(#(#left #top #right #bottom #none ) includes: edgeSymbol)
		ifFalse: [^ self error: 'invalid option'].
	self setToAdhereToEdge: edgeSymbol.
	self updateLayoutProperties.
	self updateColor! !

!PrimitivesScope methodsFor: 'BalloonEngine'!
p: 'jmv 9/2/2009 12:37'! !


!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'nice 3/16/2010 19:37'!
isibleRectangle
		while: 
			[ linesInterval do: 
				[ :lineIndex |
				| string stopCondition startIndex runLength lastPos | 
				line := aParagraph lines at: lineIndex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'StephaneDucasse 3/23/2010 21:41'!
uilder in: windowSpec rect: (0.5@0 extent: 0.5@1).
	^builder build: windowSpec
! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'AlainPlantec 1/31/2010 17:13'!
s print: d abs.
							hasBoth
								ifTrue: [s
										nextPutAll: (d > 0
												ifTrue: ['  (big endian)']
												ifFalse: ['  (little endian)'])]]].
	^ (allLabels with: allDepths collect: [:l :d | l -> d]) asArray sort: [:a :b | a value < b value]
! !

!PrimitivesScope methodsFor: 'StandardFileStream'!
/2009 18:22'! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'AlainPlantec 1/31/2010 14:46'!
hBlock: [Debugger logDebuggerStackToFile: true].
! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'dtl 12/26/2009 14:56'!
romSourcePointer: 16r5000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5FFFFFF).

	(16r1000000 to: 16r1FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	(16r3000000 to: 16r3FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	"changes file mapping"
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2FFFFFF).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4FFFFFF).

	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'nice 11/11/2009 16:56'!
d out dependents."
	| copy i |
	copy := self class new: self size + 1.
	i := 0.
	self do: [:item | copy basicAt: (i:=i+1) put: item].
	copy basicAt: (i:=i+1) put: newElement.
	^copy! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'nice 1/5/2010 15:59'!
* 72 // 96.
	].

	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"

	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'StandardFileStream' stamp: 'nice 1/5/2010 15:59'!
m then switch focus to any
	sibling menu and start scanning at the relevant end."

	| allEnabledSiblingItems index|
	allEnabledSiblingItems := self allEnabledSiblingItems.
	index := (allEnabledSiblingItems indexOf: selectedItem ifAbsent: [0 + (anInteger negative ifTrue: [1] ifFalse: [0])]) + anInteger.
	allEnabledSiblingItems do: "Ensure finite"
		[:unused | | m | m := allEnabledSiblingItems atWrap: index.
		((m isKindOf: MenuItemMorph) and: [m isEnabled]) ifTrue:
			[m owner = self owner ifFalse: [
				anEvent hand newKeyboardFocus: m owner].
				^m owner selectItem: m event: anEvent].
		"Keep looking for an enabled item"
		index := index + anInteger sign].
	^self selectItem: nil event: anEvent! !


!PrimitivesScope methodsFor: 'Process' stamp: 'nice 11/11/2009 17:29'!
At: 2 put: secondObject;
		basicAt: 3 put: thirdObject;
		basicAt: 4 put: fourthObject;
		basicAt: 5 put: fifthObject;
		yourself! !

!PrimitivesScope methodsFor: 'Process' stamp: 'AlainPlantec 1/31/2010 17:13'!
ollect: [:l :d | l -> d]) asArray sort: [:a :b | a value < b value]
! !


!PrimitivesScope methodsFor: 'BalloonBuffer' stamp: 'pmm 3/13/2010 11:22'!
airArray transcodingTable: table additionalRange: additionalRange 
	| other rangeStream newChars currentRange |
	other := BDFFontReader readOnlyFileNamed: otherFileName.
	rangeStream := pairArray readStream.
	currentRange := rangeStream next.
	newChars := PluggableSet new.
	newChars hashBlock: [ :elem | (elem at: 2) hash ].
	newChars equalBlock: [ :a :b | (a at: 2) = (b at: 2) ].
	other readChars do: 
		[ :array | | u form j code | 
		code := array at: 2.
		"code printStringHex printString displayAt: 0@0."
		code > currentRange last ifTrue: 
			[ 
			[ rangeStream atEnd not and: 
				[ currentRange := rangeStream next.
				currentRange last < code ] ] whileTrue.
			rangeStream atEnd ifTrue: 
				[ newChars addAll: chars.
				^ newChars ] ].
		(code 
			between: currentRange first
			and: currentRange last) ifTrue: 
			[ form := array at: 1.
			form ifNotNil: 
				[ j := array at: 2.
				u := table at: (j // 256 - 33) * 94 + (j \\ 256 - 33) + 1.
				u ~= -1 ifTrue: 
					[ array 
						at: 2
						put: u.
					newChars add: array.
					additionalRange do: 
						[ :e | | newArray | 
						e first = (array at: 2) ifTrue: 
							[ newArray := array shallowCopy.
							newArray 
								at: 2
								put: e second.
							newChars add: newArray ] ] ] ] ] ].
	self error: 'should not reach here'! !

!PrimitivesScope methodsFor: 'BalloonBuffer' stamp: 'nice 1/16/2010 20:57'!
nd: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !


!PrimitivesScope methodsFor: 'SerialPort' stamp: 'gvc 2/3/2010 16:22'!
w
		hResizing: #shrinkWrap;
		vResizing: #spaceFill;
		extent: w@4;
		minWidth: w;
		color: self joinColor! !

!PrimitivesScope methodsFor: 'SerialPort' stamp: 'dtl 12/24/2009 10:06'!
d"

	^ self! !

!PrimitivesScope methodsFor: 'SerialPort' stamp: 'pmm 3/13/2010 11:22'!
e first = (array at: 2) ifTrue: 
							[ newArray := array shallowCopy.
							newArray 
								at: 2
								put: e second.
							newChars add: newArray ] ] ] ] ] ].
	self error: 'should not reach here'! !

!PrimitivesScope methodsFor: 'SerialPort' stamp: 'brp 9/25/2003 13:22'!
< 10 ifTrue: [ aStream nextPut: $0. ].
	h printOn: aStream. aStream nextPut: $:.
	m < 10 ifTrue: [ aStream nextPut: $0. ].
	m printOn: aStream. aStream nextPut: $:.
	s < 10 ifTrue: [ aStream nextPut: $0. ].
	s printOn: aStream.
	n = 0 ifFalse:
		[ | z ps |
		aStream nextPut: $..
		ps := n printString padded: #left to: 9 with: $0. 
		z := ps findLast: [ :c | c asciiValue > $0 asciiValue ].
		ps from: 1 to: z do: [ :c | aStream nextPut: c ] ].
! !


!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'nice 2/13/2010 02:25'!
er parse: '+6.e+2') = 600.
	self assert: (ExtendedNumberParser parse: '+6.e+2') isFloat.

	self assert: (ExtendedNumberParser parse: '-7.e+2') = -700.
	self assert: (ExtendedNumberParser parse: '-7.e+2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') = (1/4).
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') = (-1/16).
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') isFloat.! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'FernandoOlivero 3/15/2010 23:55'!
black ! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'AlainPlantec 1/31/2010 14:46'!
startAlsoProceeds: false].
! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'FernandoOlivero 3/16/2010 00:45'!
thArguments:{ann textMorph }]]! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'nice 1/5/2010 15:59'!
a.
				(self verify: sig isSignatureOf: msg publicKey: keys last) ifTrue: [
					file
						nextChunkPut: sig;
						nextChunkPut: msg;
						nextChunkPut: keys last storeString.
				] ifFalse: [
					self error: 'ERROR!! Signature verification failed'
				].
			].
		].
	] ensure: [file close]
! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'jmv 11/4/2008 23:13'!
nated characters, inclusive.  Make no visual changes."

	self markIndex: start; pointIndex: stop + 1! !

!PrimitivesScope methodsFor: 'FileDirectory' stamp: 'AlainPlantec 12/16/2009 22:08'!
rent colors for Browser, MessageList etc..."

	^ Color lightGray! !


!PrimitivesScope methodsFor: 'Form'!
' stamp: 'nice 1/5/2010 15:59'! !


!PrimitivesScope methodsFor: 'Cursor' stamp: 'FernandoOlivero 1/27/2010 13:25'!
the prior editor."

	| stateArray |
	editor := self editorClass new morph: self.
	editor changeString: contents.
	self changed.
	^editor! !

!PrimitivesScope methodsFor: 'Cursor' stamp: 'MarcusDenker 12/11/2009 07:38'!
ged: #listSelectionIndex;
		updateContents;
		triggerEvent: #selectionIndex with: anInteger.
	self model ifNotNil: [:m | 
		self setIndexSelector ifNotNil: [:s |
			self useSelectionIndex
				ifTrue: [m perform: s with: anInteger]
				ifFalse: [m perform: s with: self selectedItem]]]! !


!PrimitivesScope methodsFor: 'DisplayScreen'!
on StandardSourceFileArray that provides a larger maximum changes file size.

The available address space for source pointers in a traditional CompiledMethod is 16r1000000 through 16r4FFFFFF. StandardSourceFileArray maps positions in the sources file to address range 16r1000000 through 16r1FFFFFF and 16r3000000 through 16r3FFFFFF, and positions in the changes file to address range 16r2000000 through 16r2FFFFFF and 16r4000000 through 16r4FFFFFF. This permits a maximum file size of 16r2000000 (32MB) for both the sources file and the changes file. 

This implementation extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'DisplayScreen' stamp: 'AlainPlantec 12/13/2009 11:28'!
self layoutInset: 0.
	! !

!PrimitivesScope methodsFor: 'DisplayScreen' stamp: 'nice 1/5/2010 15:59'!
m extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'DisplayScreen' stamp: 'AlainPlantec 1/31/2010 14:46'!
dHistory purgeUndoOnQuit: true].
! !

!PrimitivesScope methodsFor: 'DisplayScreen' stamp: 'alain.plantec 3/13/2009 15:44'!
setTextColor: Color black]
		ifFalse: [self contentMorph setTextColor: paneColor duller]! !

!PrimitivesScope methodsFor: 'DisplayScreen'!
/4/2008 23:42'! !

!PrimitivesScope methodsFor: 'DisplayScreen' stamp: 'nice 2/13/2010 02:23'!
berParser parse: '3e+-') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-1') = 3.
	self assert: (ExtendedNumberParser parse: '+3e+W') = 3.
	self assert: (ExtendedNumberParser parse: '-3e+Z') = -3.! !


!PrimitivesScope methodsFor: 'ContextPart'!
recated: aBlock explanation: aString is recommended.

Idiom: Imagine I want to deprecate the message #foo.

foo
	^ 'foo'

I can replace it with:

foo
	self deprecatedExplanation: 'The method #foo was not good. Use Bar>>newFoo instead.'
	^ 'foo'

Or, for certain cases such as when #foo implements a primitive, #foo can be renamed to #fooDeprecated.

fooDeprecated
	^ <primitive>

foo
	^ self deprecated: [self fooDeprecated] explanation: 'The method #foo was not good. Use Bar>>newFoo instead.'
! !

!PrimitivesScope methodsFor: 'ContextPart'!
odsFor: 'encoding' stamp: 'pavel.krivanek 3/2/2010 21:25'! !

!PrimitivesScope methodsFor: 'ContextPart'!
dMorph methodsFor: 'event handling' stamp: 'FernandoOlivero 3/16/2010 00:57'! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'StephaneDucasse 2/13/2010 16:06'!
' on: '13 February 2010' in: 'Pharo1.1'.
	^ self digitValueOf: char! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'gvc 2/9/2010 13:52'!
f descriptionMorph
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@0) offsets: (0@0 corner: 0@descriptionHeight));
		addMorph: self diffMorph
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1)
					offsets: (0 @ descriptionHeight corner: 0@0)).
	self
		extent: self initialExtent;
		updateDescriptionFillStyle: self paneColor! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'dtl 12/22/2009 23:05'!
ourcePointerFromFileIndex: 2 andPosition: 0] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 0 andPosition: 3] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 1 andPosition: -1] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 1 andPosition: 16r1FFFFFF] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 1 andPosition: 16r2000000] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 3 andPosition: 0] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 4 andPosition: 0] raise: Error.
	
	self assert: 16r1000000 = (sf sourcePointerFromFileIndex: 1 andPosition: 0).
	self assert: 16r1000013 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r13).
	self assert: 16r1FFFFFF = (sf sourcePointerFromFileIndex: 1 andPosition: 16rFFFFFF).
	self assert: 16r2000000 = (sf sourcePointerFromFileIndex: 2 andPosition: 0).
	self assert: 16r2000013 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r13).
	self assert: 16r2FFFFFF = (sf sourcePointerFromFileIndex: 2 andPosition: 16rFFFFFF).
	self assert: 16r3000000 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1000000).
	self assert: 16r3000013 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1000013).
	self assert: 16r3FFFFFF = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1FFFFFF).
	self assert: 16r4000000 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1000000).
	self assert: 16r4000013 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1000013).
	self assert: 16r4FFFFFF = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1FFFFFF)
! !

!PrimitivesScope methodsFor: 'ContextPart'!
dsFor: 'editing' stamp: 'FernandoOlivero 1/21/2010 12:22'! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'AlainPlantec 12/14/2009 21:35'!
tMouse at: 1 put: anEvent cursorPoint.
			self targetPoint: lastMouse first - lastMouse last.
			self positionPoint: (lastMouse first - lastMouse second)].! !

!PrimitivesScope methodsFor: 'ContextPart'!
Morph methodsFor: 'as yet unclassified' stamp: 'alain.plantec 4/9/2009 10:12'! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'MarcusDenker 12/12/2009 00:06'!
self hResizing: #spaceFill].
			self isVertical ifTrue: [self vResizing: #spaceFill]].
	! !

!PrimitivesScope methodsFor: 'ContextPart' stamp: 'FernandoOlivero 3/16/2010 00:33'!
n: self ).
	! !


!PrimitivesScope methodsFor: 'MethodContext' stamp: 'nice 11/11/2009 20:34'!
ifTrue: [newSelf basicAt: (size := size+1) put: dep]].
	selection := self species new: size.
	selection basicReplaceFrom: 1 to: size with: newSelf startingAt: 1.
	^selection! !

!PrimitivesScope methodsFor: 'MethodContext' stamp: 'StephaneDucasse 3/23/2010 21:41'!
With: builder
	| windowSpec |
	leftCngSorter := ChangeSorter new myChangeSet: ChangeSet current.
	leftCngSorter parent: self.
	rightCngSorter := ChangeSorter new myChangeSet: 
			ChangeSet secondaryChangeSet.
	rightCngSorter parent: self.

	windowSpec := builder pluggableWindowSpec new.
	windowSpec model: self.
	windowSpec label: 'Change Sorter'.
	windowSpec children: OrderedCollection new.
	leftCngSorter buildWith: builder in: windowSpec rect: (0@0 extent: 0.5@1).
	rightCngSorter buildWith: builder in: windowSpec rect: (0.5@0 extent: 0.5@1).
	^builder build: windowSpec
! !


!PrimitivesScope methodsFor: 'MatrixTransform2x3' stamp: 'dtl 12/23/2009 12:45'!
nd position"

	| hi lo |
	(index = 1 or: [index = 2])
		ifFalse: [self error: 'invalid source file index'].
	position < 0 ifTrue: [self error: 'invalid source code pointer'].
	hi := position // 16r1000000 *2 + index.
	lo := position \\ 16r1000000.
	^ hi * 16r1000000 + lo
! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3' stamp: 'brp 9/25/2003 15:38'!
s."
 
 	^ self class
 		nanoSeconds: (self asNanoSeconds truncateTo: aDuration asNanoSeconds)
 
 ! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
itor methodsFor: 'menu messages' stamp: 'jmv 11/5/2008 10:16'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3' stamp: 'nice 3/16/2010 19:37'!
lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
p: 'StephaneDucasse 10/24/2009 11:27'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
11/2/2009 00:29'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
ice 2/13/2010 00:39' prior: 0! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
1/2004 18:37'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
amp: 'cmm 10/5/2007 12:13'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3'!
DemoSettingStyle methodsFor: 'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'MatrixTransform2x3' stamp: 'nice 1/5/2010 15:59'!
pointSize ret lastValue start end encoding bbx strikeWidth minAscii maxAscii maxWidth |
	form := encoding := bbx := nil.
	self initialize.
	self readAttributes.
	height := Integer readFromString: ((properties at: #FONTBOUNDINGBOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) ifTrue: [
		pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].
		
	
	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.
	chars := self override: chars with: otherFileName ranges: otherRanges transcodingTable: (UCSTable jisx0208Table) additionalRange: additionalRange.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"
	
	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'ThirtyTwoBitRegister' stamp: 'adrian_lienhard 1/7/2009 18:19'!
nanos! !


!PrimitivesScope methodsFor: 'HostFont' stamp: 'StephaneDucasse 5/13/2010 12:09'!
assert: absent.

	dict at: #foo put: #bar.
	present := absent := false.
	dict at: #foo ifPresent: [:v| present := true] ifAbsent: [absent := true].
	self assert: present.
	self deny: absent.

	present := absent := false.
	dict at: #foo ifPresent: [:v| present := true. nil] ifAbsent: [absent := true].
	self assert: present.
	self deny: absent.
! !

!PrimitivesScope methodsFor: 'HostFont' stamp: 'nice 1/5/2010 15:59'!
scii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'HostFont' stamp: 'nice 3/6/2010 14:19'!
put: Unicode "Latin1Environment".
	EncodedCharSets at: 1+1 put: JISX0208.
	EncodedCharSets at: 2+1 put: GB2312.
	EncodedCharSets at: 3+1 put: KSX1001.
	EncodedCharSets at: 4+1 put: JISX0208.
	EncodedCharSets at: 5+1 put: JapaneseEnvironment.
	EncodedCharSets at: 6+1 put: SimplifiedChineseEnvironment.
	EncodedCharSets at: 7+1 put: KoreanEnvironment.
	EncodedCharSets at: 8+1 put: GB2312.
	"EncodedCharSets at: 9+1 put: UnicodeTraditionalChinese."
	"EncodedCharSets at: 10+1 put: UnicodeVietnamese."
	EncodedCharSets at: 12+1 put: KSX1001.
	EncodedCharSets at: 13+1 put: GreekEnvironment.
	EncodedCharSets at: 14+1 put: Latin2Environment.
	EncodedCharSets at: 15+1 put: RussianEnvironment.
	EncodedCharSets at: 16+1 put: NepaleseEnvironment.
	EncodedCharSets at: 256 put: Unicode.
! !

!PrimitivesScope methodsFor: 'HostFont'!
odsFor: 'initialize-release' stamp: 'gvc 2/9/2010 13:12'! !

!PrimitivesScope methodsFor: 'HostFont' stamp: 'dtl 12/26/2009 14:56'!
1 = (sf fileIndexFromSourcePointer: 16r3000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r3FFFFFF).

	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000000).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5000013).
	self assert: 1 = (sf fileIndexFromSourcePointer: 16r5FFFFFF).

	(16r1000000 to: 16r1FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	(16r3000000 to: 16r3FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	"changes file mapping"
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2FFFFFF).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4FFFFFF).

	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'HostFont' stamp: 'StephaneDucasse 12/25/2009 12:15'!
or: [ x isNumber and: [ y isNumber ] ])
 			ifTrue: [ x < y ]
 			ifFalse: [ x class == y class
 				ifTrue: [ x printString < y printString ]
 				ifFalse: [ x class name < y class name ] ] ].
 	^sortedKeys! !

!PrimitivesScope methodsFor: 'HostFont' stamp: 'nice 1/16/2010 20:56'!
omFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !


!PrimitivesScope methodsFor: 'ImageSegment' stamp: 'MarcusDenker 12/12/2009 00:00'!
tes includes: self edgeToAdhereTo) ifFalse: [^ byChaste].
	byChaste := byChaste reject: [:each | each edgeToAdhereTo = self edgeToAdhereTo].	
	byArrival := allDockingBars select: [:each | each edgeToAdhereTo = self edgeToAdhereTo].
	byArrival := byArrival copyAfter: self.
	^ byChaste , byArrival! !

!PrimitivesScope methodsFor: 'ImageSegment' stamp: 'cmm 2/15/2010 15:22'!
dificationTime: modificationTime   
		fileSize: fileSize! !


!PrimitivesScope methodsFor: 'Socket'!
lainPlantec 12/3/2009 06:33'! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'StephaneDucasse 5/1/2010 16:13'!
seconds nanos nanosBuffer |
	sign := (aStream peekFor: $-) ifTrue: [-1] ifFalse: [1].
	days := (aStream upTo: $:) asInteger sign: sign.
	hours := (aStream upTo: $:) asInteger sign: sign.
	minutes := (aStream upTo: $:) asInteger sign: sign.
	seconds := (aStream upTo: $.) asInteger sign: sign.
	nanosBuffer := '000000000' copy.
	nanos := nanosBuffer writeStream.
	[aStream atEnd not and: [aStream peek isDigit]]
		whileTrue: [nanos nextPut: aStream next].
		
	^ self 
		days: days 
		hours: hours 
		minutes: minutes 
		seconds: seconds 
		nanoSeconds: (nanosBuffer asInteger sign: sign)! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 1/5/2010 15:59'!
Num.

	self readCharactersInRanges: ranges storeInto: chars.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"

	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'jmv 9/2/2009 13:17'!
nt: aKeyboardEvent.
	^ true! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 1/5/2010 15:59'!
is the second test period.'. 'And finally, a third message'}.
	file := FileStream newFileNamed: 'dsa.test.out'.
	[
		msgList do: [ :msg |
			keyList do: [ :keys | | sig |
				sig := self sign: msg privateKey: keys first dsa: dsa.
				(self verify: sig isSignatureOf: msg publicKey: keys last) ifTrue: [
					file
						nextChunkPut: sig;
						nextChunkPut: msg;
						nextChunkPut: keys last storeString.
				] ifFalse: [
					self error: 'ERROR!! Signature verification failed'
				].
			].
		].
	] ensure: [file close]
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'dtl 12/26/2009 14:56'!
tionFromSourcePointer: 16r3000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r3000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r3FFFFFF).
	"changes file"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r2000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r2000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r2FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r4000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r4000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r4FFFFFF).
	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 3/5/2010 22:31'!
elf forceToScreen: (100 @ 100 extent: 200 @ 200).
	self windowPosition: 300 @ 300.
	self windowTitle: 'YooHoo!! New title'.
	self windowSize: 600 @ 400.
	(Delay forSeconds: 4) wait.! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'gvc 3/5/2010 12:43'!
s height negated));
		addMorph: self dstMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 1@1) offsets: (0@0 corner: self scrollbarMorph width negated - self mapMorph width@opts height negated));
		addMorph: self scrollbarMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self scrollbarMorph width negated - self mapMorph width@0 corner: self mapMorph width negated@opts height negated));
		addMorph: self mapMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'StephaneDucasse 5/1/2010 16:13'!
ffer asInteger sign: sign)! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 3/6/2010 14:19'!
Environment.
	EncodedCharSets at: 15+1 put: RussianEnvironment.
	EncodedCharSets at: 16+1 put: NepaleseEnvironment.
	EncodedCharSets at: 256 put: Unicode.
! !

!PrimitivesScope methodsFor: 'Socket'!
to address range 16r2000000 through 16r2FFFFFF and 16r4000000 through 16r4FFFFFF. This permits a maximum file size of 16r2000000 (32MB) for both the sources file and the changes file. 

This implementation extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'dtl 12/26/2009 14:56'!
0 = (sf filePositionFromSourcePointer: 16r2000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r2000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r2FFFFFF).
	self assert: 16r1000000 = (sf filePositionFromSourcePointer: 16r4000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r4000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r4FFFFFF).
	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'Socket'!
ationTest methodsFor: 'tests' stamp: 'brp 1/21/2004 18:36'! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 11/11/2009 16:56'!
py! !

!PrimitivesScope methodsFor: 'Socket'!
: 'MarcusDenker 12/11/2009 07:38'! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'gvc 2/9/2010 13:12'!
rence."

	^self diffMorphClass new
		borderStyle: (BorderStyle inset width: 1);
		font: self theme statusFont;
		addDependent: self;
		yourself! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'AlainPlantec 1/31/2010 14:46'!
adSetting: #optionalButtons withBlock: [CodeHolder optionalButtons: true].
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 2/13/2010 02:10'!
^ (sourceStream peekFor: $.)
		ifTrue: [self readNumberWithFractionPartNumberOfTrailingZeroInIntegerPart: numberOfTrailingZeroInIntegerPart]
		ifFalse: [self makeIntegerOrScaledInteger]! !

!PrimitivesScope methodsFor: 'Socket'!
:34'! !

!PrimitivesScope methodsFor: 'Socket'!
08 23:39'! !

!PrimitivesScope methodsFor: 'Socket'!
ledMethod is 16r1000000 through 16r4FFFFFF. StandardSourceFileArray maps positions in the sources file to address range 16r1000000 through 16r1FFFFFF and 16r3000000 through 16r3FFFFFF, and positions in the changes file to address range 16r2000000 through 16r2FFFFFF and 16r4000000 through 16r4FFFFFF. This permits a maximum file size of 16r2000000 (32MB) for both the sources file and the changes file. 

This implementation extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'Socket'!
Only simple borderStyle is implemented.

EllipseMorph new borderWidth:10; borderColor: Color green; openInWorld.
EllipseMorph new borderStyle:(SimpleBorder width: 5 color: Color blue); openInWorld.! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'cmm 9/12/2007 17:20'!
eSize: fileSize0
	directory := aFileDirectoryOrServerDirectory.
	name := name0.
	creationTime := creationTime0.
	modificationTime := modificationTime0.
	fileSize := fileSize0! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'FernandoOlivero 3/21/2010 13:01'!
and:[ self takesKeyboardFocus ].! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 2/13/2010 00:57'!
ue]! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'FernandoOlivero 1/21/2010 13:23'!
l	in: line.
	^ block stringIndex! !

!PrimitivesScope methodsFor: 'Socket'!
! !

!PrimitivesScope methodsFor: 'Socket'!
e methodsFor: 'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'alain.plantec 3/13/2009 18:21'!
2) min: 200! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'AlainPlantec 1/31/2010 14:46'!
e].
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'FernandoOlivero 3/16/2010 00:20'!
@10 extent: 200@30.
	margin :=  self borderWidth + 1.
	contents := 'Single line entry field'.
	font := self theme listFont.
	self fitHeightToFont .
	foreColor := Color black.
	
! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'cmm 11/30/2008 23:48'!
st itemsForFile: self fullName! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'jmv 11/4/2008 23:39'!
n: 1 and: string size) and: [(string at: index) isAlphaNumeric not]]
		whileTrue: [index := index + 1].
	^ index! !

!PrimitivesScope methodsFor: 'Socket' stamp: 'nice 3/16/2010 19:37'!
topConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !


!PrimitivesScope methodsFor: 'PCCByCompilationTest' stamp: 'nice 1/5/2010 15:59'!
ngElse].
	]
		on: MyResumableTestError
		do:
			[:ex |
			self doYetAnotherThing.
			ex resume: 3]! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest'!
16r2000000 (32MB) for both the sources file and the changes file. 

ExpandedSourceFileArray extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest'!
ation commentStamp: 'dew 5/21/2003 17:46' prior: 0! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest' stamp: 'jmv 11/5/2008 10:04'!
< stringSize" ifTrue:[lines addLast:{stringSize +1. lineIndex+1. stringSize}].
	^lines! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest' stamp: 'tween 4/6/2007 12:51'!
false! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest'!
initialization' stamp: 'StephaneDucasse 3/17/2010 20:55'! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest' stamp: 'AlainPlantec 12/3/2009 06:17'!
tFont;
				
				cornerStyle: (UITheme current textEntryCornerStyleIn: self);
				 hResizing: #spaceFill;
				 vResizing: #rigid;
				
				borderStyle: (BorderStyle inset width: 1);
				 color: Color white;
				 hideScrollBarsIndefinitely;
				 extent: 24 @ (UITheme current textFont height + 8);
				 setBalloonText: nil.
	pt textMorph autoFit: true;
		 wrapFlag: false;
		
		margins: (2 @ 1 corner: 2 @ 1).
	^ pt! !

!PrimitivesScope methodsFor: 'PCCByCompilationTest'!
stamp: 'MarcusDenker 3/27/2010 18:04'! !


!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'gvc 10/26/2007 21:31'!
r dialogs."
	
	^labelWidgetAllowance :=  0! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'nice 3/16/2010 19:34'!
ers remaining in the current run"! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'jmv 11/4/2008 13:06'!
ph
	^ morph! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'jmv 11/4/2008 23:02'!
dex |
	string := self string.
	index := position.
	[(index between: 1 and: string size) and: [(string at: index) isAlphaNumeric not]]
		whileTrue: [index := index - 1].
	[(index between: 1 and: string size) and: [(string at: index) isAlphaNumeric]]
		whileTrue: [index := index - 1].
	^ index + 1! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'FernandoOlivero 3/21/2010 16:55'!
self updateView.! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'nice 11/11/2009 20:15'!
].
	self error: 'access with an index out of bounds'! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'nice 2/13/2010 02:10'!
rPart := nDigits - lastNonZero.
	(sourceStream peekFor: $r)
		ifTrue: ["<base>r<integer>"
			| oldNeg pos |
			pos := sourceStream position.
			(base := integerPart) < 2
				ifTrue: ["A radix currently need to be greater than 1, ungobble the r and return the integer part"
					sourceStream skip: -1.
					^neg
						ifTrue: [base negated]
						ifFalse: [base]].
			oldNeg := neg.
			self peekSignIsMinus ifTrue: [neg := neg not].
			integerPart := self nextUnsignedIntegerOrNilBase: base.
			integerPart ifNil: [
				(sourceStream peekFor: $.) ifTrue: [self readNumberWithoutIntegerPartOrNil ifNotNil: [:aNumber | ^aNumber]].
				sourceStream position: pos.
					^oldNeg
						ifTrue: [base negated]
						ifFalse: [base]].
			numberOfTrailingZeroInIntegerPart := nDigits - lastNonZero].
	^ (sourceStream peekFor: $.)
		ifTrue: [self readNumberWithFractionPartNumberOfTrailingZeroInIntegerPart: numberOfTrailingZeroInIntegerPart]
		ifFalse: [self makeIntegerOrScaledInteger]! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest'!
tamp: 'brp 1/9/2004 06:28'! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'FernandoOlivero 3/20/2010 20:09'!
olor := Color white.
	announcer := Announcer new.
	self readOnly: false .! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'tween 4/6/2007 12:51'!
at the end of the line when it was composed."

	spaceCount := spaceCount + 1.
	destX := destX + spaceWidth + (line justifiedPadFor: spaceCount font: font).
	lastIndex := lastIndex + 1.
	^ false! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest' stamp: 'AlainPlantec 12/3/2009 06:17'!
: String;
				alwaysAccept: true;
				
				on: self
				text: #content
				accept: #content:
				readSelection: nil
				menu: nil;
				 acceptOnCR: true;
				 getEnabledSelector: nil;
				 font: UITheme current textFont;
				
				cornerStyle: (UITheme current textEntryCornerStyleIn: self);
				 hResizing: #spaceFill;
				 vResizing: #rigid;
				
				borderStyle: (BorderStyle inset width: 1);
				 color: Color white;
				 hideScrollBarsIndefinitely;
				 extent: 24 @ (UITheme current textFont height + 8);
				 setBalloonText: nil.
	pt textMorph autoFit: true;
		 wrapFlag: false;
		
		margins: (2 @ 1 corner: 2 @ 1).
	^ pt! !

!PrimitivesScope methodsFor: 'PCCByLiteralsTest'!
'! !


!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase'!
ro 3/21/2010 16:55'! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase' stamp: 'cmm 8/10/2007 12:25'!
romSeconds: creationTime! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase' stamp: 'MarcusDenker 12/11/2009 23:59'!
ounds right - (ownerBounds width // 5).
	rightRegion := rightRegion top: topRegion bottom.
	rightRegion := rightRegion bottom: bottomRegion top.

	droppedPosition := anEvent position.
	(topRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToTop].
	(bottomRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToBottom].
	(leftRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToLeft].
	(rightRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToRight].
	self beFloating! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase' stamp: 'MarcusDenker 12/11/2009 07:38'!
electionIndex: anInteger
	"Set the list selection."

	self hideList.
	anInteger = 0 ifTrue: [^self].
	listSelectionIndex := anInteger.
	self
		changed: #listSelectionIndex;
		updateContents;
		triggerEvent: #selectionIndex with: anInteger.
	self model ifNotNil: [:m | 
		self setIndexSelector ifNotNil: [:s |
			self useSelectionIndex
				ifTrue: [m perform: s with: anInteger]
				ifFalse: [m perform: s with: self selectedItem]]]! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase' stamp: 'AlainPlantec 1/31/2010 14:46'!
oadSetting: #polymorphDiffToolsUsedByDefault withBlock: [PSMCPatchMorph usedByDefault: true].
! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase'!
6/2010 00:00'! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase'!
ary methodsFor: 'converting' stamp: 'nice 10/6/2009 14:15'! !

!PrimitivesScope methodsFor: 'IslandVMTweaksTestCase' stamp: 'nice 1/5/2010 15:59'!
idth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'ImmX11' stamp: 'gvc 2/9/2010 13:13'!
(aColor alphaMixed: 0.3 with: Color white).! !


!PrimitivesScope methodsFor: 'Locale' stamp: 'nice 3/16/2010 19:34'!
line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'FernandoOlivero 3/15/2010 23:59'!
ection
	^editor notNil and: [editor hasSelection]! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'cmm 2/15/2010 15:52'!
lf fileSize asBytesDescription! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'brp 9/25/2003 14:29'!
// operand asDuration asNanoSeconds ]
 ! !

!PrimitivesScope methodsFor: 'Locale'!
tableTextMorph methodsFor: 'event handling' stamp: 'FernandoOlivero 3/16/2010 00:13'! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'dtl 12/26/2009 14:56'!
ults as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'StephaneDucasse 4/23/2010 21:55'!
) nanoSeconds = 1000000! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'StephaneDucasse 4/24/2010 10:52'!
r ANSI 5.8.2.16: [-]D:HH:MM:SS[.S]"! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'nice 1/16/2010 20:56'!
rray new.
	0 to: 16r1FFFFFFF by: 4093 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		i := sf fileIndexFromSourcePointer: a.
		self assert: i == 2.
		p := sf filePositionFromSourcePointer: a.
		self assert: p = e.
		a2 := sf sourcePointerFromFileIndex: 2 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r2000000 and: 16r2FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r4000000 and: 16r4FFFFFF)].
	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r6000000 and: 16r6FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r8000000 and: 16r8FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rA000000 and: 16rAFFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rC000000 and: 16rCFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'brp 1/21/2004 18:38'!
self assert:  (aDuration roundTo: (Duration minutes: 1)) =
	               (Duration days: 1 hours: 2 minutes: 3 seconds: 0 nanoSeconds: 0).! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'nice 2/13/2010 01:55'!
gerPart
	try and form a number with a fractionPart"
	
	^self readNumberWithoutIntegerPartOrNil ifNil: [
		"No integer part, no fractionPart, this does not look like a number..."
		^self expected: 'a digit between 0 and 9'].! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'nice 11/11/2009 17:30'!
ject with: fifthObject with: sixthObject
	^(self basicNew: 6)
		basicAt: 1 put: firstObject;
		basicAt: 2 put: secondObject;
		basicAt: 3 put: thirdObject;
		basicAt: 4 put: fourthObject;
		basicAt: 5 put: fifthObject;
		basicAt: 6 put: sixthObject;
		yourself! !

!PrimitivesScope methodsFor: 'Locale' stamp: 'nice 1/5/2010 15:59'!
t
	"Move the selection down or up (negative number) by (at least)
	the specified amount. If the item is not enabled, scan one at a time
	in that direction. If we move off the top/bottom then switch focus to any
	sibling menu and start scanning at the relevant end."

	| allEnabledSiblingItems index|
	allEnabledSiblingItems := self allEnabledSiblingItems.
	index := (allEnabledSiblingItems indexOf: selectedItem ifAbsent: [0 + (anInteger negative ifTrue: [1] ifFalse: [0])]) + anInteger.
	allEnabledSiblingItems do: "Ensure finite"
		[:unused | | m | m := allEnabledSiblingItems atWrap: index.
		((m isKindOf: MenuItemMorph) and: [m isEnabled]) ifTrue:
			[m owner = self owner ifFalse: [
				anEvent hand newKeyboardFocus: m owner].
				^m owner selectItem: m event: anEvent].
		"Keep looking for an enabled item"
		index := index + anInteger sign].
	^self selectItem: nil event: anEvent! !


!PrimitivesScope methodsFor: 'Behavior' stamp: 'nice 1/5/2010 15:59'!
rray new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'Behavior'!
stamp: 'lr 3/14/2010 21:13'! !

!PrimitivesScope methodsFor: 'Behavior' stamp: 'FernandoOlivero 3/21/2010 15:12'!
| k |
	k := aKeyboardEvent keyValue.
	k = 27 ifTrue:[ ^ self escapePressed  ].
	(k = 30 or: [ k = 31 ]) ifTrue: [ ^super keyStroke: aKeyboardEvent ].
	(k = 28 and: [ editor isAtStart ]) ifTrue: [ ^super keyStroke: aKeyboardEvent ].
	(k = 29 and: [ editor isAtEnd ]) ifTrue: [ ^super keyStroke: aKeyboardEvent ].
	self handleInteraction: [ editor processKeyStroke: aKeyboardEvent ].
	self updateFromContents .! !

!PrimitivesScope methodsFor: 'Behavior' stamp: 'jmv 9/2/2009 13:01'!
alse: [1]).
	startIndex := 1 max: startIndex - 1.
	self backTo: startIndex.
	^false! !


!PrimitivesScope methodsFor: 'Time class' stamp: 'nice 1/5/2010 15:59'!
temMorph) and: [m isEnabled]) ifTrue:
			[m owner = self owner ifFalse: [
				anEvent hand newKeyboardFocus: m owner].
				^m owner selectItem: m event: anEvent].
		"Keep looking for an enabled item"
		index := index + anInteger sign].
	^self selectItem: nil event: anEvent! !

!PrimitivesScope methodsFor: 'Time class' stamp: 'StephaneDucasse 3/23/2010 21:41'!
ightCngSorter parent: self.

	window := (SystemWindow labelled: leftCngSorter label) model: self.
	"topView minimumSize: 300 @ 200."
	leftCngSorter openAsMorphIn: window rect: (0@0 extent: 0.5@1).
	rightCngSorter openAsMorphIn: window rect: (0.5@0 extent: 0.5@1).
	^ window
! !

!PrimitivesScope methodsFor: 'Time class' stamp: 'brp 9/25/2003 13:22'!
s := self seconds abs truncated.
	n := self nanoSeconds abs. 	self negative ifTrue: [ aStream nextPut: $- ].
	d printOn: aStream. aStream nextPut: $:.
	h < 10 ifTrue: [ aStream nextPut: $0. ].
	h printOn: aStream. aStream nextPut: $:.
	m < 10 ifTrue: [ aStream nextPut: $0. ].
	m printOn: aStream. aStream nextPut: $:.
	s < 10 ifTrue: [ aStream nextPut: $0. ].
	s printOn: aStream.
	n = 0 ifFalse:
		[ | z ps |
		aStream nextPut: $..
		ps := n printString padded: #left to: 9 with: $0. 
		z := ps findLast: [ :c | c asciiValue > $0 asciiValue ].
		ps from: 1 to: z do: [ :c | aStream nextPut: c ] ].
! !


!PrimitivesScope methodsFor: 'SyntaxError class' stamp: 'adrian_lienhard 1/7/2009 18:22'!
seconds: quo
		nanoSeconds: nanos - (quo * NanosInSecond)! !


!PrimitivesScope methodsFor: 'Debugger class' stamp: 'lr 3/14/2010 21:13'!
er name"
	(smartRefStream respondsTo: #renamed)
		ifTrue: [ 
			"If in outPointers in an ImageSegment, remember original class
			name. 
			See mapClass:installIn:. Would be lost otherwise."
			(thisContext sender sender sender sender sender sender sender sender receiver class == ImageSegment
				and: [ thisContext sender sender sender sender method == (DataStream compiledMethodAt: #readArray) ])
				ifTrue: [ 
					arrayIndex := thisContext sender sender sender sender tempAt: 4.	"index var in readArray. Later safer to find i on stack
					of context."
					smartRefStream renamedConv at: arrayIndex put: symbol ].	"save original name"
			symbol := smartRefStream renamed at: symbol ifAbsent: [ symbol ] ].	"map"
	globalObj := Smalltalk globals
		at: symbol
		ifAbsent: [ 
			preSelector == nil & (constructorSelector = #yourself)
				ifTrue: [ 
					Transcript
						cr;
						show: symbol , ' is undeclared.'.
					(Undeclared includesKey: symbol)
						ifTrue: [ ^ Undeclared at: symbol ].
					Undeclared at: symbol put: nil.
					^ nil ].
			^ self error: 'Global "' , symbol , '" not found' ].
	preSelector
		ifNotNil: [ 
			Symbol
				hasInterned: preSelector
				ifTrue: [ :selector | 
					[ globalObj := globalObj perform: selector ]
						on: Error
						do: [ :ex | 
							ex messageText = 'key not found'
								ifTrue: [ ^ nil ].
							^ ex signal ] ] ].	"keep the Proxy if Project does not exist"
	constructorSelector ifNil: [ ^ globalObj ].
	Symbol
		hasInterned: constructorSelector
		ifTrue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'Debugger class' stamp: 'nice 2/13/2010 00:57'!
numberOfNonZeroFractionDigits := lastNonZero.
			numberOfTrailingZeroInFractionPart := nDigits - lastNonZero].
	self readExponent
		ifFalse: [self readScale
				ifTrue: [^self makeScaledDecimalWithNumberOfNonZeroFractionDigits: numberOfNonZeroFractionDigits
					andNumberOfTrailingZeroInFractionPart: numberOfTrailingZeroInFractionPart]].

	fractionPart isZero
		ifTrue: [mantissa := integerPart
						// (base raisedToInteger: numberOfTrailingZeroInIntegerPart).
			exponent := exponent + numberOfTrailingZeroInIntegerPart]
		ifFalse: [mantissa := integerPart
						* (base raisedToInteger: numberOfNonZeroFractionDigits) + (fractionPart // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !


!PrimitivesScope methodsFor: 'PluginBasedJPEGReadWriter class'!
ddress space for source pointers in a traditional CompiledMethod is 16r1000000 through 16r4FFFFFF. StandardSourceFileArray maps positions in the sources file to address range 16r1000000 through 16r1FFFFFF and 16r3000000 through 16r3FFFFFF, and positions in the changes file to address range 16r2000000 through 16r2FFFFFF and 16r4000000 through 16r4FFFFFF. This permits a maximum file size of 16r2000000 (32MB) for both the sources file and the changes file. 

ExpandedSourceFileArray extends the source pointer address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !


!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'nice 11/11/2009 20:34'!
Size newSelf size dep selection |
	basicSize := self basicSize.
	newSelf := self species new: basicSize.
	size := 0.
	1 to: basicSize do: [:i |
		((dep := self basicAt: i) notNil and: [aBlock value: dep]) ifTrue: [newSelf basicAt: (size := size+1) put: dep]].
	selection := self species new: size.
	selection basicReplaceFrom: 1 to: size with: newSelf startingAt: 1.
	^selection! !

!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'AlainPlantec 12/3/2009 06:17'!
eScrollBarsIndefinitely;
				 extent: 24 @ (UITheme current textFont height + 8);
				 setBalloonText: nil.
	pt textMorph autoFit: true;
		 wrapFlag: false;
		
		margins: (2 @ 1 corner: 2 @ 1).
	^ pt! !

!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'cmm 2/15/2010 13:16'!
ber of seconds offset from the DateAndTime epoch."
	^creationTime! !

!PrimitivesScope methodsFor: 'NetNameResolver class'!
p: 'brp 9/25/2003 14:29'! !

!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'nice 11/11/2009 17:19'!
'this collection is empty'! !

!PrimitivesScope methodsFor: 'NetNameResolver class'!
'
When the morph is escaped the Transcript is closed.! !

!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'nice 1/5/2010 15:59'!
= Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.
	self 
		readCharactersInRangeFrom: start
		to: end
		totalNums: charsNum
		storeInto: chars.
	chars := chars asSortedCollection: [ :x :y | (x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'NetNameResolver class' stamp: 'nice 1/16/2010 20:56'!
sert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !


!PrimitivesScope methodsFor: 'ProcessorScheduler class' stamp: 'nice 3/16/2010 19:34'!
ll setStopConditions."
	| stopCondition nowLeftInRun startIndex string lastPos |
	line := textLine.
	morphicOffset := offset.
	lineY := line top + offset y.
	lineHeight := line lineHeight.
	rightMargin := line rightMargin + offset x.
	lastIndex := line first.
	leftInRun <= 0 ifTrue: [ self setStopConditions ].
	leftMargin := (line leftMarginForAlignment: alignment) + offset x.
	destX := runX := leftMargin.
	fillBlt == nil ifFalse: 
		[ "Not right"
		fillBlt
			destX: line left
				destY: lineY
				width: line width left
				height: lineHeight;
			copyBits ].
	lastIndex := line first.
	leftInRun <= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !


!PrimitivesScope methodsFor: 'Array class' stamp: 'cmm 2/15/2010 15:22'!
fTrue: [ DirectoryEntryDirectory ]
		ifFalse: [ DirectoryEntryFile ].
	^ type
		directory: nil
		name: name0  
		creationTime: creationTime  
		modificationTime: modificationTime   
		fileSize: fileSize! !


!PrimitivesScope methodsFor: 'ByteArray class' stamp: 'jmv 9/2/2009 13:17'!
se]
		forward: false
		specialBlock:[:dummy | dummy]
		event: aKeyboardEvent.
	^true! !


!PrimitivesScope methodsFor: 'CompiledMethod class'!
antec 1/31/2010 14:46'! !


!PrimitivesScope methodsFor: 'ByteString class' stamp: 'dtl 12/26/2009 14:56'!
) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	(16r3000000 to: 16r3FFFFFF by: 811) do: [:e | self assert: 1 = (sf fileIndexFromSourcePointer: e)].
	"changes file mapping"
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r2FFFFFF).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r4FFFFFF).

	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000000).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'ByteString class' stamp: 'nice 1/5/2010 15:59'!
.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'ByteString class' stamp: 'nice 1/16/2010 20:56'!
p1 := ssf filePositionFromSourcePointer: e.
		p2 := esf filePositionFromSourcePointer: e.
		self assert: p1 = p2.
		a1 := ssf sourcePointerFromFileIndex: i1 andPosition: p1.
		a2 := esf sourcePointerFromFileIndex: i2 andPosition: p2.
		self assert: a1 = a2.
		self assert: a1= e]

! !

!PrimitivesScope methodsFor: 'ByteString class' stamp: 'nice 1/5/2010 15:59'!
RROR!! Signature verification failed'
				].
			].
		].
	] ensure: [file close]
! !

!PrimitivesScope methodsFor: 'ByteString class' stamp: 'nice 1/5/2010 15:59'!
0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.
	chars := self override: chars with: otherFileName ranges: otherRanges transcodingTable: (UCSTable jisx0208Table) additionalRange: additionalRange.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"
	
	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'Interval class'!
oryEntry methodsFor: 'access' stamp: 'cmm 9/12/2007 17:25'! !


!PrimitivesScope methodsFor: 'BalloonEngine class' stamp: 'gvc 3/5/2010 12:43'!
:= self newPanel
		addMorph: ((self newRow: {ppCheckbox}) 
						listCentering: #bottomRight).
	opts vResizing: #shrinkWrap.
	opts extent: opts minExtent.
	self
		srcMorph: self newSrcMorph;
		joinMorph: self newJoinMorph;
		dstMorph: self newDstMorph;
		scrollbarMorph: self newScrollbarMorph;
		mapMorph: self newMapMorph;
		changeProportionalLayout;
		addMorph: self srcMorph fullFrame: (LayoutFrame
			fractions: (0@0 corner: 0.5@1) offsets: (0@0 corner: self joinMorph width negated@opts height negated));
		addMorph: self joinMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 0.5@1) offsets: (self joinMorph width negated@0 corner: 0@opts height negated));
		addMorph: self dstMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 1@1) offsets: (0@0 corner: self scrollbarMorph width negated - self mapMorph width@opts height negated));
		addMorph: self scrollbarMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self scrollbarMorph width negated - self mapMorph width@0 corner: self mapMorph width negated@opts height negated));
		addMorph: self mapMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'BalloonEngine class' stamp: 'jmv 9/2/2009 13:18'!
ck value: newPosition].
	shift
		ifTrue: [self selectMark: (indices at: #fixed) point: newPosition - 1]
		ifFalse: [self selectAt: newPosition]! !


!PrimitivesScope methodsFor: 'StandardFileStream class'!
010 00:55'! !


!PrimitivesScope methodsFor: 'ZLibWriteStream class' stamp: 'StephaneDucasse 4/28/2010 22:16'!
self assert: (Duration milliSeconds: -3775) nanoSeconds = -775000000! !


!PrimitivesScope methodsFor: 'Delay class'!
hmm 4/25/2000 21:20'! !


!PrimitivesScope methodsFor: 'FileDirectory class'!
eDucasse 5/5/2010 22:01'! !


!PrimitivesScope methodsFor: 'DisplayScreen class' stamp: 'AlainPlantec 1/7/2010 22:04'!
: self theme settings menuBorderWidth
		borderColor: self theme settings menuBorderColor! !

!PrimitivesScope methodsFor: 'DisplayScreen class' stamp: 'lr 3/14/2010 21:13'!
: [ 
			preSelector == nil & (constructorSelector = #yourself)
				ifTrue: [ 
					Transcript
						cr;
						show: symbol , ' is undeclared.'.
					(Undeclared includesKey: symbol)
						ifTrue: [ ^ Undeclared at: symbol ].
					Undeclared at: symbol put: nil.
					^ nil ].
			^ self error: 'Global "' , symbol , '" not found' ].
	preSelector
		ifNotNil: [ 
			Symbol
				hasInterned: preSelector
				ifTrue: [ :selector | 
					[ globalObj := globalObj perform: selector ]
						on: Error
						do: [ :ex | 
							ex messageText = 'key not found'
								ifTrue: [ ^ nil ].
							^ ex signal ] ] ].	"keep the Proxy if Project does not exist"
	constructorSelector ifNil: [ ^ globalObj ].
	Symbol
		hasInterned: constructorSelector
		ifTrue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'DisplayScreen class'!
' stamp: 'gk 8/31/2006 01:27'! !


!PrimitivesScope methodsFor: 'StrikeFont class'!
! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'cmm 2/15/2010 15:22'!
tionTime   isDirectory: isDirectory  fileSize: fileSize
	"This is the legacy creation method we are trying to phase out.  Please use #directory:  name:  creationTime:  modificationTime:  fileSize:." 
	| type |
	type := isDirectory 
		ifTrue: [ DirectoryEntryDirectory ]
		ifFalse: [ DirectoryEntryFile ].
	^ type
		directory: nil
		name: name0  
		creationTime: creationTime  
		modificationTime: modificationTime   
		fileSize: fileSize! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'nice 3/16/2010 19:34'!
kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'brp 9/25/2003 15:07'!
ation with the 
 	same sign as aDuration. operand is a Duration or a Number."
 
 	^ operand isNumber
 		ifTrue: [ self class nanoSeconds: (self asNanoSeconds \\ operand) ]
 		ifFalse: [ self - (operand * (self // operand)) ]
 ! !

!PrimitivesScope methodsFor: 'StrikeFont class'!
tamp: 'gvc 3/5/2010 12:43'! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'dtl 12/22/2009 23:05'!
andedSourceFileArray new.
	self should: [sf sourcePointerFromFileIndex: 0 andPosition: 0] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 1 andPosition: 0] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 2 andPosition: 0] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 0 andPosition: 3] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 1 andPosition: -1] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 1 andPosition: 16r1FFFFFF] raise: Error.
	self shouldnt: [sf sourcePointerFromFileIndex: 1 andPosition: 16r2000000] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 3 andPosition: 0] raise: Error.
	self should: [sf sourcePointerFromFileIndex: 4 andPosition: 0] raise: Error.
	
	self assert: 16r1000000 = (sf sourcePointerFromFileIndex: 1 andPosition: 0).
	self assert: 16r1000013 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r13).
	self assert: 16r1FFFFFF = (sf sourcePointerFromFileIndex: 1 andPosition: 16rFFFFFF).
	self assert: 16r2000000 = (sf sourcePointerFromFileIndex: 2 andPosition: 0).
	self assert: 16r2000013 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r13).
	self assert: 16r2FFFFFF = (sf sourcePointerFromFileIndex: 2 andPosition: 16rFFFFFF).
	self assert: 16r3000000 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1000000).
	self assert: 16r3000013 = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1000013).
	self assert: 16r3FFFFFF = (sf sourcePointerFromFileIndex: 1 andPosition: 16r1FFFFFF).
	self assert: 16r4000000 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1000000).
	self assert: 16r4000013 = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1000013).
	self assert: 16r4FFFFFF = (sf sourcePointerFromFileIndex: 2 andPosition: 16r1FFFFFF)
! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'nice 1/5/2010 15:59'!
bx := nil.
	self initialize.
	self readAttributes.
	height := Integer readFromString: ((properties at: #FONTBOUNDINGBOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) 
		ifTrue: 
			[ pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10 ]
		ifFalse: [ pointSize := (ascent + descent) * 72 // 96 ].
	maxWidth := 0.
	minAscii := 2097152.
	strikeWidth := 0.
	maxAscii := 0.
	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.
	self 
		readCharactersInRangeFrom: start
		to: end
		totalNums: charsNum
		storeInto: chars.
	chars := chars asSortedCollection: [ :x :y | (x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'StrikeFont class' stamp: 'FernandoOlivero 1/21/2010 13:23'!
height baseline: font ascent.
	blockScanner := CharacterBlockScanner new.
	blockScanner text: contents asText  textStyle: TextStyle default copy.
	block := blockScanner characterBlockAtPoint: aPoint index: nil	in: line.
	^ block stringIndex! !


!PrimitivesScope methodsFor: 'HostFont class' stamp: 'FernandoOlivero 5/17/2010 13:54'!
Event 
	"A nonspecial character is to be added to the stream of characters."

	self addString: aKeyboardEvent keyCharacter asString.
	^false! !


!PrimitivesScope methodsFor: 'Socket class'!
d changes files.
! !


!PrimitivesScope methodsFor: 'Beeper class' stamp: 'FernandoOlivero 1/21/2010 14:09'!
|
	width := font widthOfString: contents.
	self extent: width + (self margin * 2) @ self height .! !


!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'AlainPlantec 12/17/2009 14:33'!
Thickness + 3)
		max: self theme expanderTitleControlButtonWidth! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'gvc 1/20/2010 11:58'!
me selectionColor].
	self layoutInset: (self theme dropListInsetFor: self).
	self buttonMorph extent: self buttonExtent.
	super themeChanged.
	self buttonMorph cornerStyle: self cornerStyle.! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'alain.plantec 5/18/2009 15:54'!
tx
						notifying: nil].
				dst isEmpty ifFalse: [
					dst := ctx prettyPrinterClass 
						format: dst
						in: ctx
						notifying: nil]].	
	self srcMorph setText: src; font: self theme textFont.
	self dstMorph setText: dst; font: self theme textFont! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'dtl 12/26/2009 14:56'!
romSourcePointer: 16r6000013).
	self assert: 2 = (sf fileIndexFromSourcePointer: 16r6FFFFFF).

	(16r2000000 to: 16r2FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 1/5/2010 15:59'!
at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'X11Encoding class'!
methodsFor: 'as yet unclassified' stamp: 'gvc 1/20/2010 11:58'! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'FernandoOlivero 3/16/2010 00:57'!
.
	self updateView! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'jmv 11/4/2008 23:36'!
elimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 1/5/2010 15:59'!
owercase beginsWith: aString].
		item isEnabled: match.
		(match and: [firstMatch isNil]) ifTrue: [firstMatch := item]].
	^firstMatch! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 1/5/2010 15:59'!
d 
	| xTable glyphs ascent descent chars charsNum height form blt lastAscii pointSize ret lastValue encoding bbx strikeWidth minAscii maxAscii maxWidth |
	form := encoding := bbx := nil.
	self initialize.
	self readAttributes.
	height := Integer readFromString: ((properties at: #FONTBOUNDINGBOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) 
		ifTrue: 
			[ pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10 ]
		ifFalse: [ pointSize := (ascent + descent) * 72 // 96 ].
	maxWidth := 0.
	minAscii := 2097152.
	strikeWidth := 0.
	maxAscii := 0.
	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.
	self 
		readCharactersInRangeFrom: start
		to: end
		totalNums: charsNum
		storeInto: chars.
	chars := chars asSortedCollection: [ :x :y | (x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'brp 1/21/2004 18:36'!
= 
		(Duration days: 0 hours: 0 minutes: 0 seconds: 0 nanoSeconds: 1).
	

! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 1/5/2010 15:59'!
m event: anEvent].
		"Keep looking for an enabled item"
		index := index + anInteger sign].
	^self selectItem: nil event: anEvent! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 1/5/2010 15:59'!
matching items."

	| firstMatch|
	self items do: [:item | | match |
		match := aString isEmpty or: [item contents asString asLowercase beginsWith: aString].
		item isEnabled: match.
		(match and: [firstMatch isNil]) ifTrue: [firstMatch := item]].
	^firstMatch! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 3/16/2010 19:37'!
kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'X11Encoding class' stamp: 'nice 11/11/2009 17:29'!
^(self basicNew: 4)
		basicAt: 1 put: firstObject;
		basicAt: 2 put: secondObject;
		basicAt: 3 put: thirdObject;
		basicAt: 4 put: fourthObject;
		yourself! !


!PrimitivesScope methodsFor: 'InternetConfiguration class'!
! !

!PrimitivesScope methodsFor: 'InternetConfiguration class' stamp: 'jmv 9/2/2009 12:38'!
^ true! !


!PrimitivesScope methodsFor: 'StructuralHandleClass class' stamp: 'FernandoOlivero 3/16/2010 00:00'!
.! !

!PrimitivesScope methodsFor: 'StructuralHandleClass class'!
p: 'lr 3/14/2010 21:13'! !


!PrimitivesScope methodsFor: 'FT2Handle class'!
ple example with a target and aspect.

self example2 
a more complex example with a target and aspect and acceptingSelector .
When the morph is accepted, pressing Cmd-S, the Transcript shows it's name'
When the morph is escaped the Transcript is closed.! !


!PrimitivesScope methodsFor: 'MD5 class' stamp: 'MarcusDenker 12/12/2009 00:00'!
s select: [:each | each edgeToAdhereTo = self edgeToAdhereTo].
	byArrival := byArrival copyAfter: self.
	^ byChaste , byArrival! !


!PrimitivesScope methodsFor: 'RBMacSpellChecker class' stamp: 'nice 1/16/2010 20:57'!
(a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !


!PrimitivesScope methodsFor: 'SampledSound class' stamp: 'nice 1/5/2010 15:59'!
atch and: [firstMatch isNil]) ifTrue: [firstMatch := item]].
	^firstMatch! !


!PrimitivesScope methodsFor: 'SimpleMIDIPort class' stamp: 'jmv 11/5/2008 10:04'!
h may change due to line wrapping of the editor).
	Subclasses using kinds of Paragraphs can instead use the service provided by it.
	"
	| lines string index lineIndex stringSize |
	string := self string.
	"Empty strings have no lines at all. Think of something."
	string isEmpty ifTrue:[^{#(1 0 0)}].
	stringSize := string size.
	lines := OrderedCollection new: (string size // 15).
	index := 0.
	lineIndex := 0.
	string linesDo:[:line |
		lines addLast: (Array
			with: (index := index + 1)
			with: (lineIndex := lineIndex + 1)
			with: (index := index + line size min: stringSize))].
	"Special workaround for last line empty."
	string last == Character cr
	"lines last last < stringSize" ifTrue:[lines addLast:{stringSize +1. lineIndex+1. stringSize}].
	^lines! !

!PrimitivesScope methodsFor: 'SimpleMIDIPort class' stamp: 'AlainPlantec 1/31/2010 14:46'!
serverMode: false].
! !

!PrimitivesScope methodsFor: 'SimpleMIDIPort class' stamp: 'gvc 2/9/2010 13:13'!
orph for the destination description."

	^self descriptionMorph lastSubmorph firstSubmorph! !


!PrimitivesScope methodsFor: 'SoundPlayer class'!
'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'SoundPlayer class'!
p: 'cmm 9/13/2007 12:24' prior: 0! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'lr 3/14/2010 21:13'!
ue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'gvc 3/5/2010 12:43'!
ph;
		joinMorph: self newJoinMorph;
		dstMorph: self newDstMorph;
		scrollbarMorph: self newScrollbarMorph;
		mapMorph: self newMapMorph;
		changeProportionalLayout;
		addMorph: self srcMorph fullFrame: (LayoutFrame
			fractions: (0@0 corner: 0.5@1) offsets: (0@0 corner: self joinMorph width negated@opts height negated));
		addMorph: self joinMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 0.5@1) offsets: (self joinMorph width negated@0 corner: 0@opts height negated));
		addMorph: self dstMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 1@1) offsets: (0@0 corner: self scrollbarMorph width negated - self mapMorph width@opts height negated));
		addMorph: self scrollbarMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self scrollbarMorph width negated - self mapMorph width@0 corner: self mapMorph width negated@opts height negated));
		addMorph: self mapMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'nice 2/13/2010 02:25'!
dedNumberParser parse: '-4r1.e-2') isFloat.! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'FernandoOlivero 3/16/2010 00:35'!
tMorph := anObject! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'nice 2/13/2010 01:54'!
astNonZero.
	self readExponent
		ifFalse: [self readScale
				ifTrue: [^self makeScaledDecimalWithNumberOfNonZeroFractionDigits: numberOfNonZeroFractionDigits
					andNumberOfTrailingZeroInFractionPart: numberOfTrailingZeroInFractionPart]].

	fractionPart isZero
		ifTrue: [mantissa := 0]
		ifFalse: [mantissa := (fractionPart // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'SoundPlayer class' stamp: 'cmm 10/5/2007 12:13'!
1 ]! !


!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 3/6/2010 14:19'!
5+1 put: JapaneseEnvironment.
	EncodedCharSets at: 6+1 put: SimplifiedChineseEnvironment.
	EncodedCharSets at: 7+1 put: KoreanEnvironment.
	EncodedCharSets at: 8+1 put: GB2312.
	"EncodedCharSets at: 9+1 put: UnicodeTraditionalChinese."
	"EncodedCharSets at: 10+1 put: UnicodeVietnamese."
	EncodedCharSets at: 12+1 put: KSX1001.
	EncodedCharSets at: 13+1 put: GreekEnvironment.
	EncodedCharSets at: 14+1 put: Latin2Environment.
	EncodedCharSets at: 15+1 put: RussianEnvironment.
	EncodedCharSets at: 16+1 put: NepaleseEnvironment.
	EncodedCharSets at: 256 put: Unicode.
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'AlainPlantec 1/31/2010 14:46'!
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'alain.plantec 4/8/2009 09:11'!
istSelectionIndex > 0
			ifTrue: [sel := self list at: self listSelectionIndex.
					sel isText
						ifTrue: [sel]
						ifFalse: [sel asString]]
			ifFalse: ['']) "needs something to keep font"! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 2/13/2010 02:25'!
(ExtendedNumberParser parse: '-4.e2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+5.e2') = 500.
	self assert: (ExtendedNumberParser parse: '+5.e2') isFloat.

	self assert: (ExtendedNumberParser parse: '+6.e+2') = 600.
	self assert: (ExtendedNumberParser parse: '+6.e+2') isFloat.

	self assert: (ExtendedNumberParser parse: '-7.e+2') = -700.
	self assert: (ExtendedNumberParser parse: '-7.e+2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') = (1/4).
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') = (-1/16).
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') isFloat.! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
rForRanges methodsFor: 'as yet unclassified' stamp: 'nice 1/5/2010 15:59'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'dtl 12/26/2009 14:56'!
inter: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 1/5/2010 15:59'!
s. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 3/16/2010 19:34'!
destX := runX := leftMargin.
	fillBlt == nil ifFalse: 
		[ "Not right"
		fillBlt
			destX: line left
				destY: lineY
				width: line width left
				height: lineHeight;
			copyBits ].
	lastIndex := line first.
	leftInRun <= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'FernandoOlivero 1/25/2010 16:56'!
hasSelection ifTrue: [ self drawSelectionOn: aCanvas ].
	self hasVisibleCaret ifTrue: [ self drawCaretOn: aCanvas].
	aCanvas drawString: contents in: (bounds insetBy: self margin) font: font color: self foreColor	! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'AlainPlantec 12/13/2009 11:28'!
alize.
	""
	selectedItem := nil.
	activeSubMenu := nil.
	fillsOwner := true.
	avoidVisibleBordersAtEdge := true.
	autoGradient := UITheme current preferGradientFill.
	""
	self setDefaultParameters.
	""
	self beFloating.
	""
	self layoutInset: 0.
	! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 1/5/2010 15:59'!
mString: (properties at: 'POINT_SIZE' asSymbol) first) // 10 ]
		ifFalse: [ pointSize := (ascent + descent) * 72 // 96 ].
	maxWidth := 0.
	minAscii := 2097152.
	strikeWidth := 0.
	maxAscii := 0.
	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.
	self 
		readCharactersInRangeFrom: start
		to: end
		totalNums: charsNum
		storeInto: chars.
	chars := chars asSortedCollection: [ :x :y | (x at: 2) <= (y at: 2) ].
	charsNum := chars size.	"undefined encodings make this different"
	chars do: 
		[ :array | | width | 
		encoding := array at: 2.
		bbx := array at: 3.
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width ].
	glyphs := Form extent: strikeWidth @ height.
	blt := BitBlt toForm: glyphs.
	"xTable := XTableForUnicodeFont new ranges: (Array with: (Array with: start with: end))."
	xTable := SparseLargeTable 
		new: end + 3
		chunkSize: 32
		arrayClass: Array
		base: start + 1
		defaultValue: -1.
	lastAscii := start.
	1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'lr 3/14/2010 21:13'!
smartRefStream renamedConv at: arrayIndex put: symbol ].	"save original name"
			symbol := smartRefStream renamed at: symbol ifAbsent: [ symbol ] ].	"map"
	globalObj := Smalltalk globals
		at: symbol
		ifAbsent: [ 
			preSelector == nil & (constructorSelector = #yourself)
				ifTrue: [ 
					Transcript
						cr;
						show: symbol , ' is undeclared.'.
					(Undeclared includesKey: symbol)
						ifTrue: [ ^ Undeclared at: symbol ].
					Undeclared at: symbol put: nil.
					^ nil ].
			^ self error: 'Global "' , symbol , '" not found' ].
	preSelector
		ifNotNil: [ 
			Symbol
				hasInterned: preSelector
				ifTrue: [ :selector | 
					[ globalObj := globalObj perform: selector ]
						on: Error
						do: [ :ex | 
							ex messageText = 'key not found'
								ifTrue: [ ^ nil ].
							^ ex signal ] ] ].	"keep the Proxy if Project does not exist"
	constructorSelector ifNil: [ ^ globalObj ].
	Symbol
		hasInterned: constructorSelector
		ifTrue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'gvc 2/10/2010 13:28'!
etBy: 2.
	self
		triggerEvent: #mapClicked
		with: (((event cursorPoint y asFloat - b top / b height) 
				min: 1) max: 0)! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'cmm 10/5/2007 17:41'!
ory copyHere: aDirectoryEntryFile! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 1/5/2010 15:59'!
d := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
2010 14:46'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'lr 3/14/2010 21:13'!
(Undeclared includesKey: symbol)
						ifTrue: [ ^ Undeclared at: symbol ].
					Undeclared at: symbol put: nil.
					^ nil ].
			^ self error: 'Global "' , symbol , '" not found' ].
	preSelector
		ifNotNil: [ 
			Symbol
				hasInterned: preSelector
				ifTrue: [ :selector | 
					[ globalObj := globalObj perform: selector ]
						on: Error
						do: [ :ex | 
							ex messageText = 'key not found'
								ifTrue: [ ^ nil ].
							^ ex signal ] ] ].	"keep the Proxy if Project does not exist"
	constructorSelector ifNil: [ ^ globalObj ].
	Symbol
		hasInterned: constructorSelector
		ifTrue: [ :selector | 
			[ ^ globalObj perform: selector withArguments: constructorArgs ]
				on: Error
				do: [ :ex | 
					ex messageText = 'key not found'
						ifTrue: [ ^ nil ].
					^ ex signal ] ].	"args not checked against Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'alain.plantec 4/9/2009 10:12'!
ct! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'StephaneDucasse 2/13/2010 16:02'!
0-35 if it is $A-$Z, and < 0 
	otherwise. This is used to parse literal numbers of radix 2-36."

	| value |
	value := char charCode.
	value <= $9 asciiValue 
		ifTrue: [^value - $0 asciiValue].
	value >= $A asciiValue 
		ifTrue: [ value <= $Z asciiValue ifTrue: [^value - $A asciiValue + 10].
				(value >= $a asciiValue and: [value <= $z asciiValue])
					 ifTrue: [^value - $a asciiValue + 10]].
	^ -1
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'gvc 2/9/2010 13:17'!
fillStyle: Color white;
		borderStyle: (self theme listNormalBorderStyleFor: self)
		! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 11/11/2009 20:33'!
om: 1 to: size with: newSelf startingAt: 1.
	^selection! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 10/6/2009 14:21'!
'When adding two different elements, the set size should be greater than one'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 3/6/2010 14:19'!
odeTraditionalChinese."
	"EncodedCharSets at: 10+1 put: UnicodeVietnamese."
	EncodedCharSets at: 12+1 put: KSX1001.
	EncodedCharSets at: 13+1 put: GreekEnvironment.
	EncodedCharSets at: 14+1 put: Latin2Environment.
	EncodedCharSets at: 15+1 put: RussianEnvironment.
	EncodedCharSets at: 16+1 put: NepaleseEnvironment.
	EncodedCharSets at: 256 put: Unicode.
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'dtl 12/26/2009 14:56'!
: 16r4000000).
	self assert: 16r1000013 = (sf filePositionFromSourcePointer: 16r4000013).
	self assert: 16r1FFFFFF = (sf filePositionFromSourcePointer: 16r4FFFFFF).
	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf filePositionFromSourcePointer: 16r0000000).
	self assert: 16r13 = (sf filePositionFromSourcePointer: 16r0000013).
	self assert: 16rFFFFFF = (sf filePositionFromSourcePointer: 16r0FFFFFF)
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 11/11/2009 17:29'!
to: aCollection size do: [:i |
		newInstance basicAt: i put: (aCollection at: i)].
	^newInstance! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'FernandoOlivero 3/15/2010 23:56'!
editor ifNotNil: [^ editor].
	^ self installEditorToReplace: nil! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 11/11/2009 20:33'!
species new: basicSize.
	size := 0.
	1 to: basicSize do: [:i |
		(dep := self basicAt: i) notNil ifTrue: [newSelf basicAt: (size := size+1) put: (aBlock value: dep)]].
	selection := self species new: size.
	selection basicReplaceFrom: 1 to: size with: newSelf startingAt: 1.
	^selection! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
nandoOlivero 3/21/2010 13:01'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 2/13/2010 02:25'!
oat.
	
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') = (1/4).
	self assert: (ExtendedNumberParser parse: '+2r1.e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') = (-1/16).
	self assert: (ExtendedNumberParser parse: '-4r1.e-2') isFloat.! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'cmm 9/27/2007 16:29'!
0
		to: endPosition! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'FernandoOlivero 3/16/2010 00:07'!
isNil ifTrue:[ self installEditorToReplace: nil].! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 1/16/2010 20:57'!
cePointerFromFileIndex: 1 andPosition: e.
		i := sf fileIndexFromSourcePointer: a.
		self assert: i == 1.
		p := sf filePositionFromSourcePointer: a.
		self assert: p = e.
		a2 := sf sourcePointerFromFileIndex: 1 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r1000000 and: 16r1FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r3000000 and: 16r3FFFFFF)].

	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r5000000 and: 16r5FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'gvc 3/5/2010 12:43'!
llFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self scrollbarMorph width negated - self mapMorph width@0 corner: self mapMorph width negated@opts height negated));
		addMorph: self mapMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 1/5/2010 15:59'!
ons e|
	buttons := self buttons.
	e := 0@0.
	buttons do: [:b | | hRes vRes |
		hRes := b hResizing.
		vRes := b vResizing.
		b
			hResizing: #shrinkWrap;
			vResizing: #shrinkWrap.
		b label: b label font: aFont.
		e := e max: b minExtent.
		b
			hResizing: hRes;
			vResizing: vRes].
	buttons do: [:b | b extent: e]! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'StephaneDucasse 5/13/2010 11:37'!
lock ifAbsent: absentBlock
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	
	self at: key ifPresent: [ :v | ^oneArgBlock value: v ].
	^absentBlock value! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'MarcusDenker 12/11/2009 09:34'!
lHeight) + (2 * self class borderWidth)
		max: rl extent + 20.
	self isResizeable ifTrue: [
		self title: self title "adjust minimumExtent".
		self minimumExtent: (ext x max: self minimumExtent x)@(ext y max: self minimumExtent y)].
	^ext! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'gvc 2/9/2010 13:13'!
nge the colours on the descriptions."
	
	self descriptionMorph fillStyle: aColor.
	self fromDescriptionMorph owner color: (aColor alphaMixed: 0.5 with: Color white).
	self toDescriptionMorph owner color: (aColor alphaMixed: 0.3 with: Color white).! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'MarcusDenker 3/27/2010 18:04'!
[ self warnAboutShadowed: aNode name ]
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 3/16/2010 20:22'!
1 := aStream basicNext) ifNil: [^ nil].
	character1 asciiValue <= 127 ifTrue: [^ character1].
	(character2 := aStream basicNext) ifNil: [^ nil].
	offset := 16rA1.
	value1 := character1 asciiValue - offset.
	value2 := character2 asciiValue - offset.
	(value1 < 0 or: [value1 > 93]) ifTrue: [^ nil].
	(value2 < 0 or: [value2 > 93]) ifTrue: [^ nil].

	nonUnicodeChar := Character leadingChar: self leadingChar code: value1 * 94 + value2.
	^ Character leadingChar: self languageEnvironment leadingChar code: nonUnicodeChar asUnicode.
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 11/16/2009 15:02'!
ragraph."

	pendingKernX := 0.
	(lastIndex < text size and: [(text at: lastIndex) = CR and: [(text at: lastIndex+1) = Character lf]])
		ifTrue: [lastIndex := lastIndex + 2]
		ifFalse: [lastIndex := lastIndex + 1].
	^false! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
andoOlivero 1/21/2010 13:23'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'LukasRenggli 5/8/2010 18:34'!
ndex put: aFile! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'dtl 12/26/2009 14:56'!
xFromSourcePointer: e)].
	(16r4000000 to: 16r4FFFFFF by: 811) do: [:e | self assert: 2 = (sf fileIndexFromSourcePointer: e)].

	"the following numeric ranges are unused but currently produces results as follows"
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'StephaneDucasse 2/13/2010 16:02'!
ue 
		ifTrue: [ value <= $Z asciiValue ifTrue: [^value - $A asciiValue + 10].
				(value >= $a asciiValue and: [value <= $z asciiValue])
					 ifTrue: [^value - $a asciiValue + 10]].
	^ -1
! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
ass"
	"A copy of a collection should always be of the same class as the instance it copies"
	
	| copy | 
	copy := self empty copy.
	self assert: copy class == self empty class.! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 3/16/2010 19:34'!
fset: offset leftInRun: leftInRun 
	"The call on the primitive (scanCharactersFrom:to:in:rightX:) will be interrupted according to an array of stop conditions passed to the scanner at which time the code to handle the stop condition is run and the call on the primitive continued until a stop condition returns true (which means the line has terminated).  leftInRun is the # of characters left to scan in the current run; when 0, it is time to call setStopConditions."
	| stopCondition nowLeftInRun startIndex string lastPos |
	line := textLine.
	morphicOffset := offset.
	lineY := line top + offset y.
	lineHeight := line lineHeight.
	rightMargin := line rightMargin + offset x.
	lastIndex := line first.
	leftInRun <= 0 ifTrue: [ self setStopConditions ].
	leftMargin := (line leftMarginForAlignment: alignment) + offset x.
	destX := runX := leftMargin.
	fillBlt == nil ifFalse: 
		[ "Not right"
		fillBlt
			destX: line left
				destY: lineY
				width: line width left
				height: lineHeight;
			copyBits ].
	lastIndex := line first.
	leftInRun <= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
ableDropListMorph class methodsFor: 'as yet unclassified' stamp: 'alain.plantec 4/9/2009 09:56'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'cmm 12/21/2007 16:04'!
:= aFileOrServerDirectory! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
2/17/2009 14:34'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'gvc 3/6/2010 17:14'!
r a new label morph for the receiver."

	^TextMorph new
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		margins: (3@0 corner: 3@0);
		lock! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'nice 11/11/2009 17:08'!
s destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."
	<primitive: 105>
	start to: stop do: [:i |
		self basicAt: i put: (replacement basicAt: repStart - start + i)]! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX'!
'! !

!PrimitivesScope methodsFor: 'HostSystemMenusMacOSX' stamp: 'cmm 12/21/2007 16:04'!
couldn't factor ServerDirectory class>>#parseFTPEntry: to the instance-side (because HTTPClient utility uses it).  Therefore, they pass a nil and then set my 'directory' immediately after.."
	directory := aFileOrServerDirectory! !


!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'StephaneDucasse 5/5/2010 22:06'!
0                       -5000000)
	(-1005                                          -1                      -5000000)
	(1234567                                        1234            567000000)
	(-1234567                                       -1234           -567000000))
		do: [ :each |
			| duration |
			duration := Duration milliSeconds: each first.
			self assert: duration asSeconds = each second.
			self assert: duration nanoSeconds = each third ]! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'MarcusDenker 12/11/2009 07:38'!
ctivate.
	self world ifNil: [^self].
	self rememberedKeyboardFocus
		ifNil: [self defaultFocusMorph ifNotNil: [:m |
				m takeKeyboardFocus]]! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'nice 11/11/2009 17:08'!
<primitive: 105>
	start to: stop do: [:i |
		self basicAt: i put: (replacement basicAt: repStart - start + i)]! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'gvc 1/20/2010 11:59'!
hanged
	"Update the button corner style from default
	to match the receiver."
	
	super themeChanged.
	self buttonMorph cornerStyle: self cornerStyle! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'jmv 11/5/2008 10:12'!
Index]! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'MarcusDenker 12/12/2009 00:06'!
self isFloating])
		ifTrue: [self listDirection: #leftToRight]
		ifFalse: [self listDirection: #topToBottom].

	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.
	self fillsOwner ifTrue: [
			self isHorizontal ifTrue: [self hResizing: #spaceFill].
			self isVertical ifTrue: [self vResizing: #spaceFill]].
	! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'StephaneDucasse 5/13/2010 11:37'!
self at: key ifPresent: [ :v | ^oneArgBlock value: v ].
	^absentBlock value! !

!PrimitivesScope methodsFor: 'HostWindowProxy' stamp: 'jmv 11/4/2008 23:36'!
"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !


!PrimitivesScope methodsFor: 'FT2GlyphSlot' stamp: 'gvc 4/18/2007 10:09'!
for the receiver in a task bar."

	^MenuIcons smallSaveIcon! !


!PrimitivesScope methodsFor: 'FT2Handle' stamp: 'MarcusDenker 12/11/2009 23:59'!
e: [
			^ self adhereToRight].
	self beFloating! !

!PrimitivesScope methodsFor: 'FT2Handle' stamp: 'nice 12/27/2009 05:15'!
mage at the stopPoint"
	| i |
	i := 0.
	^ self follow: [startPoint + ((stopPoint-startPoint) * i // nSteps)]
		while: [ | done |
				milliSecs ifNotNil: [(Delay forMilliseconds: milliSecs) wait].
				((done := (i := i+1) > nSteps) and: [stayAtEnd])
					ifTrue: [^ self "Return without clearing the image"].
				done not]! !


!PrimitivesScope methodsFor: 'FT2Face' stamp: 'jmv 11/4/2008 23:36'!
:= 1.
			here := here - 1.
			closeDelimiter := rightDelimiters at: match]
		ifFalse: 
			[openDelimiter := string at: here.
			match := rightDelimiters indexOf: openDelimiter.
			match > 0
				ifTrue: 
					["delimiter is on right -- match to the left"
					stop := here - 1.
					direction := -1.
					closeDelimiter := leftDelimiters at: match]
				ifFalse: ["no delimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'StephaneDucasse 3/23/2010 21:41'!
rter openAsMorphIn: window rect: (0@0 extent: 0.5@1).
	rightCngSorter openAsMorphIn: window rect: (0.5@0 extent: 0.5@1).
	^ window
! !

!PrimitivesScope methodsFor: 'FT2Face'!
dsFor: 'accessing' stamp: 'FernandoOlivero 1/21/2010 15:30'! !

!PrimitivesScope methodsFor: 'FT2Face'!
ettings' stamp: 'AlainPlantec 12/11/2009 10:08'! !

!PrimitivesScope methodsFor: 'FT2Face'!
ied' stamp: 'nice 1/5/2010 15:59'! !

!PrimitivesScope methodsFor: 'FT2Face'!
22:50'! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 3/16/2010 20:22'!
1 * 94 + value2.
	^ Character leadingChar: self languageEnvironment leadingChar code: nonUnicodeChar asUnicode.
! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'alain.plantec 10/20/2009 12:41'!
lected: setSelectionSel
		useIndex: useIndex) convertTo: aClass;
		 getEnabledSelector: getEnabledSel;
		 addToListSel: addToListSel;
		 default: aDefaultValue;
		 yourself! !

!PrimitivesScope methodsFor: 'FT2Face'!
iffChangeMorph methodsFor: 'initialize-release' stamp: 'gvc 2/9/2010 13:52'! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 1/16/2010 20:56'!
nFromSourcePointer: a.
		self assert: p = e.
		a2 := sf sourcePointerFromFileIndex: 2 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r2000000 and: 16r2FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r4000000 and: 16r4FFFFFF)].
	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r6000000 and: 16r6FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r8000000 and: 16r8FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rA000000 and: 16rAFFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rC000000 and: 16rCFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'brp 1/9/2004 06:32'!
Seconds: 1.
	d2 := Duration seconds: 10 nanoSeconds: 1.
	d3 := Duration seconds: 10 nanoSeconds: 2.
	
	self
		assert: (d1 = d1);
		assert: (d1 = d2);
		deny: (d1 = d3);
		assert: (d1 < d3)
! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 2/13/2010 01:54'!
se.
	fractionPart ifNil: [
		"No integer part, no fractionPart, this does not look like a number..."
		^nil].
	numberOfNonZeroFractionDigits := lastNonZero.
	numberOfTrailingZeroInFractionPart := nDigits - lastNonZero.
	self readExponent
		ifFalse: [self readScale
				ifTrue: [^self makeScaledDecimalWithNumberOfNonZeroFractionDigits: numberOfNonZeroFractionDigits
					andNumberOfTrailingZeroInFractionPart: numberOfTrailingZeroInFractionPart]].

	fractionPart isZero
		ifTrue: [mantissa := 0]
		ifFalse: [mantissa := (fractionPart // (base raisedToInteger: numberOfTrailingZeroInFractionPart)).
			exponent := exponent - numberOfNonZeroFractionDigits].

	value := self makeFloatFromMantissa: mantissa exponent: exponent base: base.
	^ neg
		ifTrue: [value isZero
				ifTrue: [Float negativeZero]
				ifFalse: [value negated]]
		ifFalse: [value]! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'brp 9/25/2003 13:42'!
rDuration: self! !

!PrimitivesScope methodsFor: 'FT2Face'!
y' stamp: 'nice 12/27/2009 05:15'! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 10/6/2009 14:15'!
s to be converted, like super super implementation."
	
	^Set withAll: self! !

!PrimitivesScope methodsFor: 'FT2Face'!
: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'FT2Face'!
FieldMorph methodsFor: 'accessing' stamp: 'FernandoOlivero 1/21/2010 14:40'! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 1/5/2010 15:59'!
: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := (ranges collect: [:r | r first]) min.
	end := (ranges collect: [:r | r second]) max + 3.

	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start +1 defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'FT2Face' stamp: 'nice 10/6/2009 14:21'!
#first -> 1.
	aSet add: assoc0 copy; add: assoc1.
	
	"Check if the two associations were added (that should happen if they are different)"
	self
		assert: (assoc0 copy ~= assoc1) ==> (aSet size > 1)
		description:
  			'When adding two different elements, the set size should be greater than one'! !

!PrimitivesScope methodsFor: 'FT2Face'!
thodsFor: 'instance creation' stamp: 'nice 11/11/2009 17:29'! !

!PrimitivesScope methodsFor: 'FT2Face'!
! !

!PrimitivesScope methodsFor: 'FT2Face'!
newDepth: 16.
		Display newDepth: 8.
		Display newDepth: 1.
Valid display depths are 1, 2, 4, 8, 16 and 32.  It is suggested that you run with your monitors setting the same, for better speed and color fidelity.  Note that this can add up to 4Mb for the Display form.  Finally, note that newDepth: ends by executing a 'ControlManager restore' which currently terminates the active process, so nothing that follows in the doit will get executed.

Depths 1, 2, 4 and 8 bits go through a color map to put color on the screen, but 16 and 32-bit color use the pixel values directly for RGB color (5 and 8 bits per, respectivlely).  The color choice an be observed by executing Color fromUser in whatever depth you are using.
! !


!PrimitivesScope methodsFor: 'FreeTypeFace' stamp: 'nice 11/11/2009 17:30'!
Object;
		basicAt: 5 put: fifthObject;
		basicAt: 6 put: sixthObject;
		yourself! !


!PrimitivesScope methodsFor: 'FT2Library' stamp: 'nice 2/13/2010 00:40'!
ign
	^true! !


!PrimitivesScope methodsFor: 'FT2MemoryFaceData'!
add up to 4Mb for the Display form.  Finally, note that newDepth: ends by executing a 'ControlManager restore' which currently terminates the active process, so nothing that follows in the doit will get executed.

Depths 1, 2, 4 and 8 bits go through a color map to put color on the screen, but 16 and 32-bit color use the pixel values directly for RGB color (5 and 8 bits per, respectivlely).  The color choice an be observed by executing Color fromUser in whatever depth you are using.
! !


!PrimitivesScope methodsFor: 'FreeTypeExternalMemory' stamp: 'AlainPlantec 1/31/2010 15:48'!
ttingstyle>
	^ 'DemoMode'! !

!PrimitivesScope methodsFor: 'FreeTypeExternalMemory' stamp: 'jmv 11/4/2008 23:02'!
t: index) isAlphaNumeric]]
		whileTrue: [index := index - 1].
	^ index + 1! !


!PrimitivesScope methodsFor: 'FT2Outline' stamp: 'gvc 2/9/2010 13:10'!
tClass: aClass
	"Answer a new instance of the receiver with the given
	old and new text and descriptions."

	^self new
		from: old
		to: new
		contextClass: aClass;
		fromDescription: oldLabel;
		toDescription: newLabel! !

!PrimitivesScope methodsFor: 'FT2Outline' stamp: 'StephaneDucasse 12/25/2009 12:15'!
treamContents: [ :stream |
 								self keysDo: [ :each | stream nextPut: each ] ].
 	sortedKeys sort: [ :x :y |
 		"Should really be use <obj, string, num> compareSafely..."
 		((x isString and: [ y isString ])
 			or: [ x isNumber and: [ y isNumber ] ])
 			ifTrue: [ x < y ]
 			ifFalse: [ x class == y class
 				ifTrue: [ x printString < y printString ]
 				ifFalse: [ x class name < y class name ] ] ].
 	^sortedKeys! !


!PrimitivesScope methodsFor: 'FT2Version' stamp: 'FernandoOlivero 3/30/2010 20:54'!
oFont.! !


!PrimitivesScope methodsFor: 'Clipboard' stamp: 'gvc 2/9/2010 13:17'!
layoutInset: 1.
		(self newRow: {self newLabel: 'Changed'})
			layoutInset: 1;
			listCentering: #bottomRight})
		layoutInset: 0;
		cellInset: 2;
		fillStyle: Color white;
		borderStyle: (self theme listNormalBorderStyleFor: self)
		! !

!PrimitivesScope methodsFor: 'Clipboard' stamp: 'nice 1/5/2010 15:59'!
ncodings make this different"
	
	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'ExternalClipboard' stamp: 'nice 1/5/2010 15:59'!
do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'ExternalClipboard' stamp: 'nice 2/13/2010 02:23'!
assert: (ExtendedNumberParser parse: '1e') = 1.
	self assert: (ExtendedNumberParser parse: '1eZ') = 1.
	self assert: (ExtendedNumberParser parse: '+1eW') = 1.
	self assert: (ExtendedNumberParser parse: '-1eX') = -1.
	
	self assert: (ExtendedNumberParser parse: '2e-') = 2.
	self assert: (ExtendedNumberParser parse: '2e--1') = 2.
	self assert: (ExtendedNumberParser parse: '2e-+1') = 2.
	self assert: (ExtendedNumberParser parse: '2e-Z') = 2.
	self assert: (ExtendedNumberParser parse: '+2e-W') = 2.
	self assert: (ExtendedNumberParser parse: '-2e-X') = -2.
	
	self assert: (ExtendedNumberParser parse: '3e+') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-') = 3.
	self assert: (ExtendedNumberParser parse: '3e+-1') = 3.
	self assert: (ExtendedNumberParser parse: '+3e+W') = 3.
	self assert: (ExtendedNumberParser parse: '-3e+Z') = -3.! !

!PrimitivesScope methodsFor: 'ExternalClipboard'!
3/2003 08:03'! !

!PrimitivesScope methodsFor: 'ExternalClipboard'!
mples' stamp: 'StephaneDucasse 2/2/2010 21:55'! !

!PrimitivesScope methodsFor: 'ExternalClipboard' stamp: 'nice 2/13/2010 02:25'!
rParser parse: '-.7e+2') = -70.
	self assert: (ExtendedNumberParser parse: '-.7e+2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+2r.1e-2') = (1/8).
	self assert: (ExtendedNumberParser parse: '+2r.1e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r.1e-2') = (-1/64).
	self assert: (ExtendedNumberParser parse: '-4r.1e-2') isFloat.! !


!PrimitivesScope methodsFor: 'BlockClosure'!
or: 'as yet unclassified' stamp: 'AlainPlantec 12/3/2009 09:10'! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'brp 9/25/2003 13:22'!
alse:
		[ | z ps |
		aStream nextPut: $..
		ps := n printString padded: #left to: 9 with: $0. 
		z := ps findLast: [ :c | c asciiValue > $0 asciiValue ].
		ps from: 1 to: z do: [ :c | aStream nextPut: c ] ].
! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'StephaneDucasse 2/2/2010 21:55'!
to call initRandomFromUser if you are merely checking a signature."
	"DigitalSignatureAlgorithm testExamplesFromDisk"

	FileStream 
		readOnlyFileNamed: 'dsa.test.out' 
		do: [ :file |
			| msg sig publicKey |
			[file atEnd] whileFalse: [
				sig := file nextChunk.
				msg := file nextChunk.
				publicKey := Compiler evaluate: file nextChunk.
				(self verify: sig isSignatureOf: msg publicKey: publicKey) 
					ifTrue: [Transcript show: 'SUCCESS: ',msg; cr.]
					ifFalse: [self error: 'ERROR!! Signature verification failed']]]! !

!PrimitivesScope methodsFor: 'BlockClosure'!
though I offer no protocol, my name provides a way to distinguish this special instance from all other Forms. This is useful, for example, in dealing with saving and restoring the system.
	To change the depth of your Display...
		Display newDepth: 16.
		Display newDepth: 8.
		Display newDepth: 1.
Valid display depths are 1, 2, 4, 8, 16 and 32.  It is suggested that you run with your monitors setting the same, for better speed and color fidelity.  Note that this can add up to 4Mb for the Display form.  Finally, note that newDepth: ends by executing a 'ControlManager restore' which currently terminates the active process, so nothing that follows in the doit will get executed.

Depths 1, 2, 4 and 8 bits go through a color map to put color on the screen, but 16 and 32-bit color use the pixel values directly for RGB color (5 and 8 bits per, respectivlely).  The color choice an be observed by executing Color fromUser in whatever depth you are using.
! !

!PrimitivesScope methodsFor: 'BlockClosure'!
(1 to: self size do: [:i | (self at: i) doSomething]) to be inefficient.
This is because #size and #at: both require scanning for nils.
For this reason, DependentsArray though sequenceable, is not a subclass of SequenceableCollection.! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'lr 3/14/2010 21:13'!
Renamed"
	^ nil! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'MarcusDenker 12/11/2009 07:38'!
b takeKeyboardFocus]]! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'MarcusDenker 12/12/2009 00:00'!
sition before the receiver.  
	 
	The predominance of individual living in the same chaste is  
	determinated by the arrival order. "

	| allDockingBars byChaste byArrival |
	(self owner isNil or: [self owner isHandMorph]) ifTrue: [^ #()].

	allDockingBars := self owner dockingBars.

	byChaste := allDockingBars select: [:each | predominantChastes includes: each edgeToAdhereTo].
	(predominantChastes includes: self edgeToAdhereTo) ifFalse: [^ byChaste].
	byChaste := byChaste reject: [:each | each edgeToAdhereTo = self edgeToAdhereTo].	
	byArrival := allDockingBars select: [:each | each edgeToAdhereTo = self edgeToAdhereTo].
	byArrival := byArrival copyAfter: self.
	^ byChaste , byArrival! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'MarcusDenker 12/11/2009 23:58'!
oAdhereToEdge: edgeSymbol.
	self updateLayoutProperties.
	self updateColor! !

!PrimitivesScope methodsFor: 'BlockClosure'!
ryFieldMorph methodsFor: 'accessing' stamp: 'FernandoOlivero 1/21/2010 12:14'! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'jmv 11/4/2008 23:14'!
nt + 1! !

!PrimitivesScope methodsFor: 'BlockClosure'!
ng loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'BlockClosure'!
'MarcusDenker 12/11/2009 23:58'! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'FernandoOlivero 3/16/2010 00:45'!
Unary
			ifTrue:[ anObject perform: aSelector]
			ifFalse:[anObject perform: aSelector withArguments:{ann textMorph }]]! !

!PrimitivesScope methodsFor: 'BlockClosure' stamp: 'nice 1/5/2010 15:59'!
Table at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !


!PrimitivesScope methodsFor: 'InputEventFetcher' stamp: 'dtl 12/26/2009 14:56'!
leIndexFromSourcePointer: 16r0000000).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0000013).
	self assert: 0 = (sf fileIndexFromSourcePointer: 16r0FFFFFF)

! !

!PrimitivesScope methodsFor: 'InputEventFetcher'!
ethodsFor: 'operations' stamp: 'brp 9/25/2003 15:38'! !

!PrimitivesScope methodsFor: 'InputEventFetcher'!
! !


!PrimitivesScope methodsFor: 'InputEventSensor'!
jmv 9/2/2009 12:37'! !

!PrimitivesScope methodsFor: 'InputEventSensor' stamp: 'FernandoOlivero 3/16/2010 00:12'!
nd newKeyboardFocus: self.
	self handleInteraction: [ editor mouseDown: evt index: (self characterIndexAtPoint: evt cursorPoint) ]! !

!PrimitivesScope methodsFor: 'InputEventSensor' stamp: 'nice 3/16/2010 19:34'!
n and the call on the primitive continued until a stop condition returns true (which means the line has terminated).  leftInRun is the # of characters left to scan in the current run; when 0, it is time to call setStopConditions."
	| stopCondition nowLeftInRun startIndex string lastPos |
	line := textLine.
	morphicOffset := offset.
	lineY := line top + offset y.
	lineHeight := line lineHeight.
	rightMargin := line rightMargin + offset x.
	lastIndex := line first.
	leftInRun <= 0 ifTrue: [ self setStopConditions ].
	leftMargin := (line leftMarginForAlignment: alignment) + offset x.
	destX := runX := leftMargin.
	fillBlt == nil ifFalse: 
		[ "Not right"
		fillBlt
			destX: line left
				destY: lineY
				width: line width left
				height: lineHeight;
			copyBits ].
	lastIndex := line first.
	leftInRun <= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !


!PrimitivesScope methodsFor: 'MD5'!
ng' stamp: 'AlainPlantec 1/31/2010 14:46'! !


!PrimitivesScope methodsFor: 'SHA1' stamp: 'jmv 11/4/2008 23:49'!
e the selection is in view."

	self selectFrom: anInterval first to: anInterval last! !

!PrimitivesScope methodsFor: 'SHA1' stamp: 'nice 1/16/2010 20:56'!
FromSourcePointer: e.
		self assert: p1 = p2].
	16r4FFFFFF to: 16r4FFFFFF by: 811 do: [:e |
		i1 := ssf fileIndexFromSourcePointer: e.
		i2 := esf fileIndexFromSourcePointer: e.
		self assert: i1 = i2.
		p1 := ssf filePositionFromSourcePointer: e.
		p2 := esf filePositionFromSourcePointer: e.
		self assert: p1 = p2.
		a1 := ssf sourcePointerFromFileIndex: i1 andPosition: p1.
		a2 := esf sourcePointerFromFileIndex: i2 andPosition: p2.
		self assert: a1 = a2.
		self assert: a1= e]

! !

!PrimitivesScope methodsFor: 'SHA1'!
ExpandedSourceFileArray methodsFor: 'sourcePointer conversion' stamp: 'dtl 12/23/2009 12:45'! !


!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'StephaneDucasse 4/24/2010 19:50'!
ation  nanoSeconds: 2) seconds = 0.	
	self assert: (Duration  seconds: 2) seconds = 2.	
	self assert: (Duration  days: 1 hours: 2 minutes: 3 seconds:4) seconds = (4).
	self deny: (Duration  days: 1 hours: 2 minutes: 3 seconds:4) seconds = (1*24*60*60+(2*60*60)+(3*60)+4).	! !

!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'StephaneDucasse 2/2/2010 21:55'!
publicKey |
			[file atEnd] whileFalse: [
				sig := file nextChunk.
				msg := file nextChunk.
				publicKey := Compiler evaluate: file nextChunk.
				(self verify: sig isSignatureOf: msg publicKey: publicKey) 
					ifTrue: [Transcript show: 'SUCCESS: ',msg; cr.]
					ifFalse: [self error: 'ERROR!! Signature verification failed']]]! !

!PrimitivesScope methodsFor: 'SecurityManager'!
:32'! !

!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'jmv 11/4/2008 23:36'!
iters := ')]}>''"
'.
	openDelimiter := string at: here - 1.
	match := leftDelimiters indexOf: openDelimiter.
	match > 0
		ifTrue: 
			["delimiter is on left -- match to the right"
			start := here.
			direction := 1.
			here := here - 1.
			closeDelimiter := rightDelimiters at: match]
		ifFalse: 
			[openDelimiter := string at: here.
			match := rightDelimiters indexOf: openDelimiter.
			match > 0
				ifTrue: 
					["delimiter is on right -- match to the left"
					stop := here - 1.
					direction := -1.
					closeDelimiter := leftDelimiters at: match]
				ifFalse: ["no delimiters -- select a token"
					direction := -1]].
	level := 1.
	[level > 0 and: [direction > 0
			ifTrue: [here < string size]
			ifFalse: [here > 1]]]
		whileTrue: 
			[hereChar := string at: (here := here + direction).
			match = 0
				ifTrue: ["token scan goes left, then right"
					hereChar tokenish
						ifTrue: [here = 1
								ifTrue: 
									[start := 1.
									"go right if hit string start"
									direction := 1]]
						ifFalse: [direction < 0
								ifTrue: 
									[start := here + 1.
									"go right if hit non-token"
									direction := 1]
								ifFalse: [level := 0]]]
				ifFalse: ["bracket match just counts nesting level"
					hereChar = closeDelimiter
						ifTrue: [level := level - 1"leaving nest"]
						ifFalse: [hereChar = openDelimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'jmv 11/4/2008 23:36'!
elimiter 
									ifTrue: [level := level + 1"entering deeper nest"]]]].

	level > 0 ifTrue: ["in case ran off string end"	here := here + direction].
	direction > 0
		ifTrue: [self selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'SecurityManager'!
stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'nice 1/5/2010 15:59'!
keys last)
					ifFalse: [self error: 'ERROR!! Signature verification failed'].
			].
		] as: 'verify msgLen = ',msg size printString count: count
	].
! !

!PrimitivesScope methodsFor: 'SecurityManager' stamp: 'nice 1/5/2010 15:59'!
readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].
		
	
	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.
	chars := self override: chars with: otherFileName ranges: otherRanges transcodingTable: (UCSTable jisx0208Table) additionalRange: additionalRange.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"
	
	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'SmalltalkImage'!
ces are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'MarcusDenker 12/11/2009 23:57'!
ibleBordersAtEdge]! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 10/5/2009 10:16'!
hich aBlock evaluates to true."

	| newCollection |
	newCollection := self copyEmpty.
	self associationsDo: [ :each |
		(aBlock value: each value) ifTrue: [
			newCollection add: each copy ] ].
	^newCollection! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'brp 1/21/2004 18:38'!
nanoSeconds: 0).
	self assert:  (aDuration roundTo: (Duration hours: 1)) =
	               (Duration days: 1 hours: 2 minutes: 0 seconds: 0 nanoSeconds: 0).	
	self assert:  (aDuration roundTo: (Duration minutes: 1)) =
	               (Duration days: 1 hours: 2 minutes: 3 seconds: 0 nanoSeconds: 0).! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 2/13/2010 02:25'!
assert: (ExtendedNumberParser parse: '-4r.1e-2') = (-1/64).
	self assert: (ExtendedNumberParser parse: '-4r.1e-2') isFloat.! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'AlainPlantec 1/31/2010 17:01'!
Values: self depthChoices;
		notInStyle.
	(aBuilder setting: #displayFullscreen)
		label: 'Fullscreen mode' translated;
		parent: #desktopSettings;
		target: #Display;
		getSelector: #isFullScreen;
		setSelector: #fullScreen:;
		description: 'On platforms that support it, set full-screen mode' translated;
		default: false.
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'gvc 2/9/2010 13:52'!
scriptionMorph: self newDescriptionMorph.
	descriptionHeight := self descriptionMorph minExtent y.
	self
		changeProportionalLayout;
		addMorph: self descriptionMorph
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@0) offsets: (0@0 corner: 0@descriptionHeight));
		addMorph: self diffMorph
		fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1)
					offsets: (0 @ descriptionHeight corner: 0@0)).
	self
		extent: self initialExtent;
		updateDescriptionFillStyle: self paneColor! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 1/16/2010 20:56'!
testChangesFileAddressRange
	"Test file position to source pointer address translation for the changes file"
	
	| sf i p a a2 |
	sf := ExpandedSourceFileArray new.
	0 to: 16r1FFFFFFF by: 4093 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		i := sf fileIndexFromSourcePointer: a.
		self assert: i == 2.
		p := sf filePositionFromSourcePointer: a.
		self assert: p = e.
		a2 := sf sourcePointerFromFileIndex: 2 andPosition: p.
		self assert: a2 = a].
	0 to: 16rFFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r2000000 and: 16r2FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r4000000 and: 16r4FFFFFF)].
	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r6000000 and: 16r6FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r8000000 and: 16r8FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rA000000 and: 16rAFFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rC000000 and: 16rCFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 1/5/2010 15:59'!
esizing: hRes;
			vResizing: vRes].
	buttons do: [:b | b extent: e]! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
address space using bit 25 of the source pointer to identify the external sources and changes files, with the remaining high order bits treated as address extension. This limits the number of external file references to two (the traditional sources and changes files). If additional external file references are needed in the future, some higher order bits in the source pointer address space should be allocated for that purpose.

The use of bit 25 of the source pointer for file references permits backward compatibility with StandardSourceFileArray, with essentially unlimited address space expansion for the sources and changes files.
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'gk 8/30/2006 23:20'!
nds: 0
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 11/16/2009 15:02'!
.
	^false! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 2/13/2010 02:10'!
eg := neg.
			self peekSignIsMinus ifTrue: [neg := neg not].
			integerPart := self nextUnsignedIntegerOrNilBase: base.
			integerPart ifNil: [
				(sourceStream peekFor: $.) ifTrue: [self readNumberWithoutIntegerPartOrNil ifNotNil: [:aNumber | ^aNumber]].
				sourceStream position: pos.
					^oldNeg
						ifTrue: [base negated]
						ifFalse: [base]].
			numberOfTrailingZeroInIntegerPart := nDigits - lastNonZero].
	^ (sourceStream peekFor: $.)
		ifTrue: [self readNumberWithFractionPartNumberOfTrailingZeroInIntegerPart: numberOfTrailingZeroInIntegerPart]
		ifFalse: [self makeIntegerOrScaledInteger]! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 3/5/2010 22:31'!
ranslateBy: 210 @ 450) test2"
	"Should
		a) open a window with the upper left portion of the current Display
		b) update the middle area with part of Display
		c) move the window from 210 @ 450 to 300 @ 300
		d) change the window title
		e) change the window size from 400 @ 400 to 600 @ 400
		f) wait 4 seconds so you can see the result
		g) close the window via the garbage collecttor finalizing it"
	self open.
	Display displayOn: self.
	self forceToScreen.
	Display displayOn: self at: -100 @ -200.
	self forceToScreen: (100 @ 100 extent: 200 @ 200).
	self windowPosition: 300 @ 300.
	self windowTitle: 'YooHoo!! New title'.
	self windowSize: 600 @ 400.
	(Delay forSeconds: 4) wait.! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 10/20/2009 23:20'!
ts: [:s| self keysDo: [:key| s nextPut: key]]! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'MarcusDenker 12/12/2009 00:06'!
Properties
	"private - update the layout properties based on adhering,  
	fillsOwner and avoidVisibleBordersAtEdge preferencs"

	(self isHorizontal or: [self isFloating])
		ifTrue: [self listDirection: #leftToRight]
		ifFalse: [self listDirection: #topToBottom].

	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.
	self fillsOwner ifTrue: [
			self isHorizontal ifTrue: [self hResizing: #spaceFill].
			self isVertical ifTrue: [self vResizing: #spaceFill]].
	! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
: 'alain.plantec 4/9/2009 11:03'! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'jmv 9/2/2009 13:17'!
e - Move cursor from position in current line to same position in
	next line. If next line too short, put at end. If shift key down,
	select."

	self closeTypeIn.
	self 
		moveCursor:[:position | self
				sameColumn: position
				newLine:[:line | line + 1]
				forward: true]
		forward: true
		specialBlock:[:dummy | dummy]
		event: aKeyboardEvent.
	^true! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'tween 4/6/2007 12:51'!
fied. 
	Padding must be added to the base width of the space according to 
	which space in the line this space is and according to the amount of 
	space that remained at the end of the line when it was composed."

	spaceCount := spaceCount + 1.
	destX := destX + spaceWidth + (line justifiedPadFor: spaceCount font: font).
	lastIndex := lastIndex + 1.
	^ false! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 12/27/2009 05:15'!
t].
				((done := (i := i+1) > nSteps) and: [stayAtEnd])
					ifTrue: [^ self "Return without clearing the image"].
				done not]! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 3/16/2010 20:22'!
asciiValue - offset.
	(value1 < 0 or: [value1 > 93]) ifTrue: [^ nil].
	(value2 < 0 or: [value2 > 93]) ifTrue: [^ nil].

	nonUnicodeChar := Character leadingChar: self leadingChar code: value1 * 94 + value2.
	^ Character leadingChar: self languageEnvironment leadingChar code: nonUnicodeChar asUnicode.
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'FernandoOlivero 3/21/2010 16:55'!
.
	contents = oldContents ifFalse: [
		self activeHand keyboardFocus == self ifTrue: [ self activeHand newKeyboardFocus: nil ].
		editor := nil ].
	self selectAll. 
	self updateView.! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 1/5/2010 15:59'!
s first dsa: dsa.
		"self inform: 'Signature created'."
		self timeDirect: [
			count timesRepeat: [
				(self verify: sig isSignatureOf: msg publicKey: keys last)
					ifFalse: [self error: 'ERROR!! Signature verification failed'].
			].
		] as: 'verify msgLen = ',msg size printString count: count
	].
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'StephaneDucasse 4/24/2010 19:48'!
er of seconds the receiver represents."
 
 	^ (seconds rem: SecondsInMinute)! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'StephaneDucasse 5/5/2010 22:06'!
-567000000))
		do: [ :each |
			| duration |
			duration := Duration milliSeconds: each first.
			self assert: duration asSeconds = each second.
			self assert: duration nanoSeconds = each third ]! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
sFor: 'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'jmv 11/4/2008 23:36'!
selectFrom: start to: here - 1]
		ifFalse: [self selectFrom: here + 1 to: stop]! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 3/16/2010 19:37'!
"The central display routine. The call on the primitive 
	(scanCharactersFrom:to:in:rightX:) will be interrupted according to an 
	array of stop conditions passed to the scanner at which time the code to 
	handle the stop condition is run and the call on the primitive continued 
	until a stop condition returns true (which means the line has 
	terminated)."
	"leftInRun is the # of characters left to scan in the current run;
		when 0, it is time to call 'self setStopConditions'"
	| leftInRun |
	morphicOffset := 0 @ 0.
	leftInRun := 0.
	self 
		initializeFromParagraph: aParagraph
		clippedBy: visibleRectangle.
	ignoreColorChanges := false.
	paragraph := aParagraph.
	foregroundColor := paragraphColor := aParagraph foregroundColor.
	backgroundColor := aParagraph backgroundColor.
	aParagraph backgroundColor isTransparent 
		ifTrue: [ fillBlt := nil ]
		ifFalse: 
			[ fillBlt := bitBlt copy.	"Blt to fill spaces, tabs, margins"
			fillBlt
				sourceForm: nil;
				sourceOrigin: 0 @ 0.
			fillBlt fillColor: aParagraph backgroundColor ].
	rightMargin := aParagraph rightMarginForDisplay.
	lineY := aParagraph topAtLineIndex: linesInterval first.
	bitBlt destForm 
		deferUpdatesIn: visibleRectangle
		while: 
			[ linesInterval do: 
				[ :lineIndex |
				| string stopCondition startIndex runLength lastPos | 
				line := aParagraph lines at: lineIndex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
d ( 
pressing cmd-s),i send acceptingSelector to my target.

I only provide behavior for overall font or fontColor modification.


self example1
a simple example with a target and aspect.

self example2 
a more complex example with a target and aspect and acceptingSelector .
When the morph is accepted, pressing Cmd-S, the Transcript shows it's name'
When the morph is escaped the Transcript is closed.! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'StephaneDucasse 3/23/2010 21:41'!
w myChangeSet: 
			ChangeSet secondaryChangeSet.
	rightCngSorter parent: self.

	windowSpec := builder pluggableWindowSpec new.
	windowSpec model: self.
	windowSpec label: 'Change Sorter'.
	windowSpec children: OrderedCollection new.
	leftCngSorter buildWith: builder in: windowSpec rect: (0@0 extent: 0.5@1).
	rightCngSorter buildWith: builder in: windowSpec rect: (0.5@0 extent: 0.5@1).
	^builder build: windowSpec
! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
odsFor: 'accessing' stamp: 'jmv 11/4/2008 14:33'! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'AlainPlantec 1/31/2010 17:01'!
layDepth) 
		label: 'Display depth' translated;
		parent: #appearance;
		target: #Display; 
		getSelector: #depth;
		setSelector: #newDepth:;
		domainValues: self depthChoices;
		notInStyle.
	(aBuilder setting: #displayFullscreen)
		label: 'Fullscreen mode' translated;
		parent: #desktopSettings;
		target: #Display;
		getSelector: #isFullScreen;
		setSelector: #fullScreen:;
		description: 'On platforms that support it, set full-screen mode' translated;
		default: false.
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'StephaneDucasse 4/28/2010 22:16'!
Duration nanoSeconds: 1000000)  asMilliSeconds = 1.
	self assert: (Duration seconds: 1)  asMilliSeconds = 1000.	
	self assert: (Duration nanoSeconds: 1000000)  asMilliSeconds = 1.
	self assert: (Duration nanoSeconds: 1000000)  asMilliSeconds = 1.
	self assert: aDuration   asMilliSeconds = 93784000.
	self assert: (Duration milliSeconds: 3775) asSeconds = 3.
	self assert: (Duration milliSeconds: 3775) nanoSeconds = 775000000.
	self assert: (Duration milliSeconds: -3775) asSeconds = -3.
	self assert: (Duration milliSeconds: -3775) nanoSeconds = -775000000! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'nice 1/5/2010 15:59'!
BOX) at: 2).
	ascent := Integer readFromString: (properties at: 'FONT_ASCENT' asSymbol) first.
	descent := Integer readFromString: (properties at: 'FONT_DESCENT' asSymbol) first.
	(properties includesKey: 'POINT_SIZE' asSymbol) ifTrue: [
		pointSize := (Integer readFromString: (properties at: 'POINT_SIZE' asSymbol) first) // 10.
	] ifFalse: [
		pointSize := (ascent + descent) * 72 // 96.
	].
		
	
	maxWidth := 0.
	minAscii := 16r200000.
	strikeWidth := 0.
	maxAscii := 0.

	charsNum := Integer readFromString: (properties at: #CHARS) first.
	chars := Set new: charsNum.

	self readCharactersInRanges: ranges storeInto: chars.
	chars := self override: chars with: otherFileName ranges: otherRanges transcodingTable: (UCSTable jisx0208Table) additionalRange: additionalRange.

	chars := chars asSortedCollection: [:x :y | (x at: 2) <= (y at: 2)].
	charsNum := chars size. "undefined encodings make this different"
	
	chars do: [:array | | width |
		encoding := array at: 2.
		bbx := array at: 3..
		width := bbx at: 1.
		maxWidth := maxWidth max: width.
		minAscii := minAscii min: encoding.
		maxAscii := maxAscii max: encoding.
		strikeWidth := strikeWidth + width.
	].

	glyphs := Form extent: strikeWidth@height.
	blt := BitBlt toForm: glyphs.
	start := ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min.
	end := ((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 3.
	"xRange := Array with: (Array with: ((ranges collect: [:r | r first]), (additionalRange collect: [:r2 | r2 first])) min
						with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !

!PrimitivesScope methodsFor: 'SmalltalkImage' stamp: 'brp 1/16/2004 14:17'!
= Duration month: #January.
	feb := Duration month: #February.
	dec := Duration month: #December.
	
	self 
		assert: jan = (Year current months first duration);
		assert: feb = (Year current months second duration);
		assert: dec = (Year current months last duration)

		
! !

!PrimitivesScope methodsFor: 'SmalltalkImage'!
r: 'typing/selecting keys' stamp: 'jmv 9/2/2009 12:38'! !


!PrimitivesScope methodsFor: 'MultiCharacterScanner' stamp: 'nice 1/5/2010 15:59'!
with: (((ranges collect: [:r | r second]), (additionalRange collect: [:r2 | r2 second])) max + 2))."
	"xTable := XTableForUnicodeFont new
		ranges: xRange."
	xTable := SparseLargeTable new: end chunkSize: 64 arrayClass: Array base: start defaultValue: -1.
	lastAscii := start.
	xTable at: lastAscii + 2 put: 0.
	1 to: charsNum do: [:i |
		form := (chars at: i) first.
		encoding := (chars at: i) second.
		bbx := (chars at: i) third.
		"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
		lastValue := xTable at: lastAscii + 1 + 1.
		xTable at: encoding + 1 put: lastValue.
		blt copy: (((xTable at: encoding+1)@(ascent - (bbx at: 2) - (bbx at: 4)))
				extent: (bbx at: 1)@(bbx at: 2))
			from: 0@0 in: form.
		xTable at: encoding+2 put: (xTable at: encoding+1)+(bbx at: 1).
		lastAscii := encoding.
	].
	xTable at: xTable size put: (xTable at: xTable size - 1).
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret at: 1 put: xTable.
	ret at: 2 put: glyphs.
	ret at: 3 put: minAscii.
	ret at: 4 put: maxAscii.
	ret at: 5 put: maxWidth.
	ret at: 6 put: ascent.
	ret at: 7 put: descent.
	ret at: 8 put: pointSize.
	^ret.
" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"
! !


!PrimitivesScope methodsFor: 'RBMacSpellChecker' stamp: 'gvc 3/5/2010 12:43'!
rner: 0.5@1) offsets: (0@0 corner: self joinMorph width negated@opts height negated));
		addMorph: self joinMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 0.5@1) offsets: (self joinMorph width negated@0 corner: 0@opts height negated));
		addMorph: self dstMorph fullFrame: (LayoutFrame
			fractions: (0.5@0 corner: 1@1) offsets: (0@0 corner: self scrollbarMorph width negated - self mapMorph width@opts height negated));
		addMorph: self scrollbarMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self scrollbarMorph width negated - self mapMorph width@0 corner: self mapMorph width negated@opts height negated));
		addMorph: self mapMorph fullFrame: (LayoutFrame
			fractions: (1@0 corner: 1@1) offsets: (self mapMorph width negated@0 corner: 0@opts height negated));
		addMorph: opts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !


!PrimitivesScope methodsFor: 'ReverbSound' stamp: 'jmv 9/2/2009 13:17'!
lf 
		moveCursor:[:position | self
				sameColumn: position
				newLine:[:line | line + 1]
				forward: true]
		forward: true
		specialBlock:[:dummy | dummy]
		event: aKeyboardEvent.
	^true! !


!PrimitivesScope methodsFor: 'SampledSound'!
ditor provides basic functionality for single line text editing. It does not handle fonts and styles, aligning and Smalltalk utilities. It handles one single line.
CellStyleEditor allows entering alphabetic characters using only number keys, like most cell phones do.! !


!PrimitivesScope methodsFor: 'FFT' stamp: 'gvc 3/5/2010 12:43'!
pts fullFrame: (LayoutFrame
			fractions: (0@1 corner: 1@1) offsets: (0@opts height negated corner: 0@0)).
	exv := ExclusiveWeakMessageSend newSharedState.
	exh := ExclusiveWeakMessageSend newSharedState.
	self srcMorph
		when: #vScroll send: #srcScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self dstMorph exclusive: exh.
	self dstMorph
		when: #vScroll send: #dstScroll: to: self exclusive: exv;
		when: #hScroll send: #hScrollValue: to: self srcMorph  exclusive: exh.
	self
		linkSubmorphsToSplitters;
		extent: self initialExtent! !


!PrimitivesScope methodsFor: 'SimpleMIDIPort'!
dsFor: 'setting loading' stamp: 'AlainPlantec 1/31/2010 14:46'! !

!PrimitivesScope methodsFor: 'SimpleMIDIPort' stamp: 'StephaneDucasse 5/5/2010 22:06'!
duration nanoSeconds = each third ]! !

!PrimitivesScope methodsFor: 'SimpleMIDIPort' stamp: 'nice 3/16/2010 19:34'!
<= 0 
		ifTrue: [ nowLeftInRun := text runLengthFor: lastIndex ]
		ifFalse: [ nowLeftInRun := leftInRun ].
	destY := lineY + line baseline - font ascent.
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string.
	[
		startIndex := lastIndex.
		lastPos := destX @ destY.
		stopCondition := self 
			scanCharactersFrom: lastIndex
			to: runStopIndex
			in: string
			rightX: rightMargin
			stopConditions: stopConditions
			kern: kern.
		lastIndex >= startIndex ifTrue: 
			[ font 
				displayString: string
				on: bitBlt
				from: startIndex
				to: lastIndex
				at: lastPos
				kern: kern ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition)
			or: [lastIndex > runStopIndex]
	] whileFalse.
	^ runStopIndex - lastIndex	"Number of characters remaining in the current run"! !

!PrimitivesScope methodsFor: 'SimpleMIDIPort' stamp: 'nice 3/16/2010 19:37'!
which time the code to 
	handle the stop condition is run and the call on the primitive continued 
	until a stop condition returns true (which means the line has 
	terminated)."
	"leftInRun is the # of characters left to scan in the current run;
		when 0, it is time to call 'self setStopConditions'"
	| leftInRun |
	morphicOffset := 0 @ 0.
	leftInRun := 0.
	self 
		initializeFromParagraph: aParagraph
		clippedBy: visibleRectangle.
	ignoreColorChanges := false.
	paragraph := aParagraph.
	foregroundColor := paragraphColor := aParagraph foregroundColor.
	backgroundColor := aParagraph backgroundColor.
	aParagraph backgroundColor isTransparent 
		ifTrue: [ fillBlt := nil ]
		ifFalse: 
			[ fillBlt := bitBlt copy.	"Blt to fill spaces, tabs, margins"
			fillBlt
				sourceForm: nil;
				sourceOrigin: 0 @ 0.
			fillBlt fillColor: aParagraph backgroundColor ].
	rightMargin := aParagraph rightMarginForDisplay.
	lineY := aParagraph topAtLineIndex: linesInterval first.
	bitBlt destForm 
		deferUpdatesIn: visibleRectangle
		while: 
			[ linesInterval do: 
				[ :lineIndex |
				| string stopCondition startIndex runLength lastPos | 
				line := aParagraph lines at: lineIndex.
				lastIndex := line first.
				self setStopConditions.	" causes an assignment to inst var.  alignment "
				leftMargin := aParagraph 
					leftMarginForDisplayForLine: lineIndex
					alignment: (alignment ifNil: [ textStyle alignment ]).
				destX := runX := leftMargin.
				line := aParagraph lines at: lineIndex.
				lineHeight := line lineHeight.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: visibleRectangle left
							destY: lineY
							width: visibleRectangle width
							height: lineHeight;
						copyBits ].
				lastIndex := line first.
				leftInRun <= 0 ifTrue: 
					[ self setStopConditions.	"also sets the font"
					leftInRun := text runLengthFor: line first ].
				destY := lineY + line baseline - font ascent.	"Should have happened in setFont"
				runLength := leftInRun.
				runStopIndex := lastIndex + (runLength - 1) min: line last.
				leftInRun := leftInRun - (runStopIndex - lastIndex + 1).
				spaceCount := 0.
				string := text string.
				self handleIndentation.
				[
					startIndex := lastIndex.
					lastPos := destX @ destY.
					stopCondition := self 
						scanCharactersFrom: lastIndex
						to: runStopIndex
						in: string
						rightX: rightMargin
						stopConditions: stopConditions
						kern: kern.
					lastIndex >= startIndex ifTrue: 
						[ font 
							displayString: string
							on: bitBlt
							from: startIndex
							to: lastIndex
							at: lastPos
							kern: kern ].
					"see setStopConditions for stopping conditions for displaying."
					self perform: stopCondition
				] whileFalse.
				fillBlt == nil ifFalse: 
					[ fillBlt
						destX: destX
							destY: lineY
							width: visibleRectangle right - destX
							height: lineHeight;
						copyBits ].
				lineY := lineY + lineHeight ] ]! !


!PrimitivesScope methodsFor: 'ADPCMCodec' stamp: 'jmv 9/2/2009 13:17'!
ine. If prior line too short, put at end"

	self closeTypeIn.
	self
		moveCursor: [:position | self
				sameColumn: position
				newLine:[:line | line - 1]
				forward: false]
		forward: false
		specialBlock:[:dummy | dummy]
		event: aKeyboardEvent.
	^true! !

!PrimitivesScope methodsFor: 'ADPCMCodec' stamp: 'nice 1/5/2010 15:59'!
Point
		from: 0
		to: self size
		during: 
			[:bar | | n | 
			n := 0.
			self keys select: 
					[:key | 
					bar value: (n := n + 1).
					(self systemNavigation allReferencesTo: (self associationAt: key)) isEmpty]]! !

!PrimitivesScope methodsFor: 'ADPCMCodec' stamp: 'AlainPlantec 1/31/2010 14:46'!
self loadSetting: #soundThemeClass withBlock: [PolymorphSystemSettings soundThemeClass: NullSoundTheme].
! !

!PrimitivesScope methodsFor: 'ADPCMCodec' stamp: 'cmm 9/12/2007 17:36'!
tory
	"Answer the FileDirectory in which I reside."
	^ directory! !


!PrimitivesScope methodsFor: 'GSMCodec' stamp: 'gvc 2/9/2010 13:52'!
orner: 0@0)).
	self
		extent: self initialExtent;
		updateDescriptionFillStyle: self paneColor! !

!PrimitivesScope methodsFor: 'GSMCodec'!
ing keys' stamp: 'jmv 11/4/2008 23:48'! !

!PrimitivesScope methodsFor: 'GSMCodec' stamp: 'MarcusDenker 12/11/2009 23:57'!
dCustomMenuItems: aMenu hand: aHandMorph 
	"Populate aMenu with appropriate menu items for a  
	yellow-button (context menu) click."
	super addCustomMenuItems: aMenu hand: aHandMorph.

	aMenu addLine.
	aMenu addUpdating: #autoGradientString action: #toggleAutoGradient.
	self isFloating
		ifFalse: [
			aMenu addUpdating: #fillsOwnerString action: #toggleFillsOwner.
			aMenu addUpdating: #avoidVisibleBordersAtEdgeString action: #toggleAvoidVisibleBordersAtEdge]! !


!PrimitivesScope methodsFor: 'SoundRecorder'!
object.

When dependents are reclaimed, they are replaced by an UndefinedObject in the DependentsArray.
This is why instances of this class will take care to iterate only on non nil elements.
These nil also cause loops written as (1 to: self size do: [:i | (self at: i) doSomething]) to be inefficient.
This is because #size and #at: both require scanning for nils.
For this reason, DependentsArray though sequenceable, is not a subclass of SequenceableCollection.! !

!PrimitivesScope methodsFor: 'SoundRecorder' stamp: 'cmm 9/12/2007 17:40'!
me) ]! !

!PrimitivesScope methodsFor: 'SoundRecorder'!
oryEntryFile methodsFor: 'stream access' stamp: 'cmm 2/15/2010 13:41'! !

!PrimitivesScope methodsFor: 'SoundRecorder' stamp: 'nice 2/13/2010 02:10'!
ekFor: $.) ifTrue: [self readNumberWithoutIntegerPartOrNil ifNotNil: [:aNumber | ^aNumber]].
				sourceStream position: pos.
					^oldNeg
						ifTrue: [base negated]
						ifFalse: [base]].
			numberOfTrailingZeroInIntegerPart := nDigits - lastNonZero].
	^ (sourceStream peekFor: $.)
		ifTrue: [self readNumberWithFractionPartNumberOfTrailingZeroInIntegerPart: numberOfTrailingZeroInIntegerPart]
		ifFalse: [self makeIntegerOrScaledInteger]! !

!PrimitivesScope methodsFor: 'SoundRecorder' stamp: 'alain.plantec 5/18/2009 15:54'!
rc; font: self theme textFont.
	self dstMorph setText: dst; font: self theme textFont! !


!PrimitivesScope methodsFor: 'NSStringStream'!
rride' stamp: 'gvc 10/26/2007 21:31'! !


!PrimitivesScope methodsFor: 'NSMultiByteBinaryOrTextStream' stamp: 'gvc 2/9/2010 13:13'!
ht-hand side of the patch,
	typically 'incoming' or 'changed'."

	self toDescriptionMorph contents: aString! !

!PrimitivesScope methodsFor: 'NSMultiByteBinaryOrTextStream' stamp: 'AlainPlantec 1/31/2010 14:46'!
Block: [StandardFonts menuFont: (LogicalFont familyName: 'DejaVu Sans' fallbackFamilyNames: nil pointSize: 16 stretchValue: 5 weightValue: 400 slantValue: 0)].
! !


!PrimitivesScope methodsFor: 'NSRWBinaryOrTextStream' stamp: 'alain.plantec 4/9/2009 09:56'!
d: getEnabledSel
		default: '' ! !


!PrimitivesScope methodsFor: 'NSDecoderInflateStream'!
current selection' stamp: 'jmv 11/4/2008 13:20'! !


!PrimitivesScope methodsFor: 'NSAbstractDeflateStream' stamp: 'FernandoOlivero 1/25/2010 16:51'!
elta := (font widthOfString: contents from: 1 to: editor startIndex-1).
	caretRectangle := top + (delta @0) extent: 1 @ font height .
	aCanvas fillRectangle: caretRectangle color:  self cursorColor.! !


!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'nice 2/13/2010 02:10'!
e: ["A radix currently need to be greater than 1, ungobble the r and return the integer part"
					sourceStream skip: -1.
					^neg
						ifTrue: [base negated]
						ifFalse: [base]].
			oldNeg := neg.
			self peekSignIsMinus ifTrue: [neg := neg not].
			integerPart := self nextUnsignedIntegerOrNilBase: base.
			integerPart ifNil: [
				(sourceStream peekFor: $.) ifTrue: [self readNumberWithoutIntegerPartOrNil ifNotNil: [:aNumber | ^aNumber]].
				sourceStream position: pos.
					^oldNeg
						ifTrue: [base negated]
						ifFalse: [base]].
			numberOfTrailingZeroInIntegerPart := nDigits - lastNonZero].
	^ (sourceStream peekFor: $.)
		ifTrue: [self readNumberWithFractionPartNumberOfTrailingZeroInIntegerPart: numberOfTrailingZeroInIntegerPart]
		ifFalse: [self makeIntegerOrScaledInteger]! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'AlainPlantec 1/31/2010 14:46'!
lbackFamilyNames: nil pointSize: 18 stretchValue: 5 weightValue: 400 slantValue: 1)].
! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'gvc 3/5/2010 12:43'!
ndowExtent! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'nice 1/5/2010 15:59'!
1 
		to: charsNum
		do: 
			[ :i | 
			form := (chars at: i) first.
			encoding := (chars at: i) second.
			bbx := (chars at: i) third.
			"lastAscii+1 to: encoding-1 do: [:a | xTable at: a+2 put: (xTable at: a+1)]."
			lastValue := xTable at: lastAscii + 1 + 1.
			xTable 
				at: encoding + 1
				put: lastValue.
			blt 
				copy: ((xTable at: encoding + 1) @ (ascent - (bbx at: 2) - (bbx at: 4)) extent: (bbx at: 1) @ (bbx at: 2))
				from: 0 @ 0
				in: form.
			xTable 
				at: encoding + 2
				put: (xTable at: encoding + 1) + (bbx at: 1).
			lastAscii := encoding ].
	xTable zapDefaultOnlyEntries.
	ret := Array new: 8.
	ret 
		at: 1
		put: xTable.
	ret 
		at: 2
		put: glyphs.
	ret 
		at: 3
		put: minAscii.
	ret 
		at: 4
		put: maxAscii.
	ret 
		at: 5
		put: maxWidth.
	ret 
		at: 6
		put: ascent.
	ret 
		at: 7
		put: descent.
	ret 
		at: 8
		put: pointSize.
	^ ret
	" ^{xTable. glyphs. minAscii. maxAscii. maxWidth. ascent. descent. pointSize}"! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'nice 11/11/2009 17:29'!
sicAt: 3 put: thirdObject;
		yourself! !

!PrimitivesScope methodsFor: 'NSFileStream'!
ses such as when #foo implements a primitive, #foo can be renamed to #fooDeprecated.

fooDeprecated
	^ <primitive>

foo
	^ self deprecated: [self fooDeprecated] explanation: 'The method #foo was not good. Use Bar>>newFoo instead.'
! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'StephaneDucasse 3/31/2010 22:03'!
= EntryFieldMorph new.
	e position: 80@200.
	e width: 600.
	e onAcceptSend: #flash to: e.
	e onEscapeSend: #delete to: e. 
	^ e! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'MarcusDenker 12/11/2009 23:57'!
String action: #toggleAutoGradient.
	self isFloating
		ifFalse: [
			aMenu addUpdating: #fillsOwnerString action: #toggleFillsOwner.
			aMenu addUpdating: #avoidVisibleBordersAtEdgeString action: #toggleAvoidVisibleBordersAtEdge]! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'AlainPlantec 4/15/2010 11:41'!
method that sets the moving and fixed indices according to some flags."
	| indices |
	indices := Dictionary new.
	self flag: 'to be reviewed'.
	(shiftPressed and: [false "Preferences selectionsMayShrink"])
		ifTrue: [
			indices at: #moving put: self pointIndex.
			indices at: #fixed put: self markIndex
		] ifFalse: [
			forward
				ifTrue:[
					indices at: #moving put: self stopIndex.
					indices at: #fixed put: self startIndex.
				] ifFalse: [
					indices at: #moving put: self startIndex.
					indices at: #fixed put: self stopIndex.
				]
		].
	^indices! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'nice 2/13/2010 02:25'!
arser parse: '+.5e2') isFloat.

	self assert: (ExtendedNumberParser parse: '+.6e+2') = 60.
	self assert: (ExtendedNumberParser parse: '+.6e+2') isFloat.

	self assert: (ExtendedNumberParser parse: '-.7e+2') = -70.
	self assert: (ExtendedNumberParser parse: '-.7e+2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '+2r.1e-2') = (1/8).
	self assert: (ExtendedNumberParser parse: '+2r.1e-2') isFloat.
	
	self assert: (ExtendedNumberParser parse: '-4r.1e-2') = (-1/64).
	self assert: (ExtendedNumberParser parse: '-4r.1e-2') isFloat.! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'nice 1/16/2010 20:57'!
d: 16r1FFFFFF)].
	16r1000000 to: 16r1FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r3000000 and: 16r3FFFFFF)].

	16r2000000 to: 16r2FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r5000000 and: 16r5FFFFFF)].
	16r3000000 to: 16r3FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r7000000 and: 16r7FFFFFF)].
	16r4000000 to: 16r4FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16r9000000 and: 16r9FFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rB000000 and: 16rBFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rD000000 and: 16rDFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 1 andPosition: e.
		self assert: (a between: 16rF000000 and: 16rFFFFFFF)]
! !

!PrimitivesScope methodsFor: 'NSFileStream' stamp: 'MarcusDenker 12/11/2009 09:34'!
the keyboard
	focus by default when the dialog is opened."
	
	^self defaultButton
		ifNil: [(self respondsTo: #nextMorphWantingFocus)
					ifTrue: [	self nextMorphWantingFocus]]
		ifNotNil: [:b | b enabled ifTrue: [b]]! !


!PrimitivesScope methodsFor: 'NSLimitedWriteStream'!
! !


!PrimitivesScope methodsFor: 'NSZipEncoder' stamp: 'nice 1/16/2010 20:56'!
16rA000000 and: 16rAFFFFFF)].
	16r5000000 to: 16r5FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rC000000 and: 16rCFFFFFF)].
	16r6000000 to: 16r6FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16rE000000 and: 16rEFFFFFF)].
	16r7000000 to: 16r7FFFFFF by: 811 do: [:e |
		a := sf sourcePointerFromFileIndex: 2 andPosition: e.
		self assert: (a between: 16r10000000 and: 16r10FFFFFF)]



! !

!PrimitivesScope methodsFor: 'NSZipEncoder' stamp: 'nice 1/5/2010 15:59'!
"Have the drawers paint what is needed"
		regions do:[:drawerAndRect| (drawerAndRect at: 1) forceToScreen].
	].! !

!PrimitivesScope methodsFor: 'NSZipEncoder' stamp: 'StephaneDucasse 10/24/2009 11:27'!
nal select: [:value |value even].
	even at: #two put: 'deux'.

	self assert: (original at: #two) = 2
 	   description: 'modifying a selection should not modify the original'! !


!PrimitivesScope methodsFor: 'Handle' stamp: 'brp 1/16/2004 14:17'!
);
		assert: feb = (Year current months second duration);
		assert: dec = (Year current months last duration)

		
! !


!PrimitivesScope methodsFor: 'ImageSegmentRootStub' stamp: 'AlainPlantec 12/14/2009 21:35'!
or resizing."
	
	target ifNil: [^self].
	self theme settings fastDragging
		ifTrue: [target doFastWindowReframe: self edgeName] 
		ifFalse: [
			lastMouse at: 1 put: anEvent cursorPoint.
			self targetPoint: lastMouse first - lastMouse last.
			self positionPoint: (lastMouse first - lastMouse second)].! !


!PrimitivesScope methodsFor: 'ObjectTracer' stamp: 'MarcusDenker 12/11/2009 23:59'!
ion) ifTrue: [
			^ self adhereToBottom].
	(leftRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToLeft].
	(rightRegion containsPoint: droppedPosition) ifTrue: [
			^ self adhereToRight].
	self beFloating! !


!PrimitivesScope methodsFor: 'PseudoContext' stamp: 'brp 1/21/2004 18:37'!
minutes: 3 seconds: 0 nanoSeconds: 0).! !


!PrimitivesScope methodsFor: 'NSTUpdateCrc' stamp: 'alain.plantec 4/9/2009 11:30'!
updateList! !


!PrimitivesScope methodsFor: 'NSTDeflating' stamp: 'nice 1/5/2010 15:59'!
ownSelector' 'mouseUpSelector' 'mouseEnterSelector' 'mouseLeaveSelector' 'mouseEnterDraggingSelector' 'mouseLeaveDraggingSelector' 'doubleClickSelector' 'keyStrokeSelector') 
		do: 
			[:aName | | aVal | 
			(aVal := self instVarNamed: aName) notNil 
				ifTrue: [aStream nextPutAll: '; ' , aName , '=' , aVal]].
	(recipients := self allRecipients) notEmpty 
		ifTrue: 
			[aStream nextPutAll: ' recipients: '.
			recipients printOn: aStream]! !


!PrimitivesScope methodsFor: 'NSTInflating'!
ecuted.

Depths 1, 2, 4 and 8 bits go through a color map to put color on the screen, but 16 and 32-bit color use the pixel values directly for RGB color (5 and 8 bits per, respectivlely).  The color choice an be observed by executing Color fromUser in whatever depth you are using.
! !


!PrimitivesScope methodsFor: 'NSTInflateStream' stamp: 'gvc 2/10/2010 13:31'!
1))
			when: #mapClicked
			send: #mapClicked:
			to: self! !
