Object subclass: #A
	instanceVariableNames: 'var1 x'
	classVariableNames: 'Coucou'
	poolDictionaries: ''
	category: 'Handles-ClassTest'!
  
!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
initialize
	var1 := 'var1'! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
isA
	^ true! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
isB
	^ false! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
self
	^ self! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
send
	Object new! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
testReturn
	^ 'failures'! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
testVar
	^ var1 printString! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
toto
	^ self! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
var1
	^ var1! !

!A methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
var1: aObject 
	var1 := aObject! !


A subclass: #AA
	instanceVariableNames: 'otherOne'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!AA methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
initialize
	super initialize.
	otherOne := 'toto'! !


Object subclass: #B
	instanceVariableNames: 'var2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
activeTestWrap
	^ self test2! !

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
initialize
	var2 := 'var2'! !

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
isA
	^ false! !

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
isB
	^ true! !

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
test2
	^ var2! !

!B methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
testReturn
	^ 'success'! !



Object subclass: #CapabilityTestClass
	instanceVariableNames: 'instance1 instance2 temp2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!CapabilityTestClass methodsFor: 'private' stamp: 'JB 12/2/2010 15:07'!
thisIsPrivateMethod
	^ 'You access to a private zone'! !


!CapabilityTestClass methodsFor: 'public' stamp: 'JB 12/2/2010 15:07'!
storeAndReturnSelf
	| aObject |
	aObject := self.
	^ aObject! !

!CapabilityTestClass methodsFor: 'public' stamp: 'JB 12/2/2010 15:07'!
storeAndReturnSelf2
	temp2 := self.
	^ temp2! !

!CapabilityTestClass methodsFor: 'public' stamp: 'JB 12/2/2010 15:07'!
takeCareAboutSelf
	^ self! !

!CapabilityTestClass methodsFor: 'public' stamp: 'JB 12/2/2010 15:07'!
thisIsPublic
	^ 'It is public'! !

!CapabilityTestClass methodsFor: 'public' stamp: 'JB 12/2/2010 15:07'!
thisIsPublicInterface
	^ self thisIsPrivateMethod! !


Object subclass: #HelloWorld
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!HelloWorld methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
helloWorld
	^ 'hello in HelloWorld'! !


Object subclass: #MirrorHandleClassTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!MirrorHandleClassTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
readAccess
	^ 'success'! !


MirrorHandleClassTest subclass: #MirrorHandleSubClassTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!MirrorHandleSubClassTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
lookupReadSend
	^ self readAccess! !

!MirrorHandleSubClassTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
superReadSend
	^ super readAccess! !

!MirrorHandleSubClassTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
toOverLoad
	^ 'NotOverload'! !


AbstractMirrorHandle subclass: #MirrorHandleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!MirrorHandleTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
mirrorOverLookSend
	^ self readAccess! !

!MirrorHandleTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
mirrorOverSuperSend
	^ self superReadSend! !

!MirrorHandleTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
mirrorSend
	^ 'mirror'! !

!MirrorHandleTest methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
toOverLoad
	^ 'success'! !


Object subclass: #MyBeeper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!MyBeeper methodsFor: 'play interface' stamp: 'JB 12/2/2010 15:07'!
play
	SoundService default beep! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MyBeeper class
	instanceVariableNames: 'default'!

!MyBeeper class methodsFor: 'beeping' stamp: 'JB 12/2/2010 15:07'!
beep
	self default
		ifNil: [self beepPrimitive]
		ifNotNil: [self default play]! !

!MyBeeper class methodsFor: 'beeping' stamp: 'JB 12/2/2010 15:07'!
beepPrimitive
	SoundSettings soundEnabled
		ifTrue: [self primitiveBeep]! !


!MyBeeper class methodsFor: 'customize' stamp: 'JB 12/2/2010 15:07'!
clearDefault
	default := nil! !

!MyBeeper class methodsFor: 'customize' stamp: 'JB 12/2/2010 15:07'!
default
	default isNil
		ifTrue: [default := self newDefault].
	^ default! !

!MyBeeper class methodsFor: 'customize' stamp: 'JB 12/2/2010 15:07'!
newDefault
	^ self new! !

!MyBeeper class methodsFor: 'customize' stamp: 'JB 12/2/2010 15:07'!
setDefault: t1 
	default := t1! !


HelloWorld subclass: #SubclassOfHelloWorld
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Handles-ClassTest'!

!SubclassOfHelloWorld methodsFor: 'as yet unclassified' stamp: 'JB 12/2/2010 15:07'!
upHelloWorld
	^ 'upHello in SubClassOfHelloWorld'! !
