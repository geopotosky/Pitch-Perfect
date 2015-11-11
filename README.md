====================
Pitch-Perfect README
====================

NOTE: App converted to Swift 2.0 on 11/11/15



“Pitch Perfect” is a voice-changing app that records sound/a voice and allows the user to play it back using 5 effects.


------------------
Record Sound Scene
------------------

Files:
------
RecordSoundViewController.swift

The Record Sound scene displays a Microphone icon. The user is instructed to “tap to record”. 

•	Tap the microphone icon and record a sound or your voice.
•	Tap the microphone icon again to pause the recording.
•	Tap the microphone icon a third time to resume recording at the point of the pause.
•	Tap the STOP button to transition to the Play Sound scene.


----------------
Play Sound Scene
----------------

Files:
------
PlaySoundsViewController.swift

The Play Sounds scene displays 5 sound effect buttons. Tap a button to hear your recording played back with a sound effect added.

•	Tap the snail button to hear the recording with a slow motion effect.
•	Tap the rabbit button to hear the recording with a fast motion effect.
•	Tap the chipmunk button to hear the recording with a chipmunk sound effect.
•	Tap the Darth Vader mask button to hear the recording with a Darth Vader sound effect.
•	Tap the ghost button to hear the recording with a ghostly echo sound effect.
•	Tap the Stop button to stop the sound playback.
•	Tap the Record back button to go back to the Record Sound scene.


----------------
Other App Files:
----------------

Object Files:
-------------

RecordAudio.swift: 
•	Primary object for storing record data


