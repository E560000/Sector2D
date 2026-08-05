--All the variables
startTime=0
GameplayAudioPlaying=0
backgroundMusicPlaying=0
settingsMusicPlaying=0 
--constant for math purposes
--epsilon for helping with float comparisons
epsilon=0.001
pi=math.pi
langle=0
rangle=0
colourA={r=1,g=1,b=1}
colourB={r=1,g=1,b=1}
leftstate="unmoved"
rightstate="unmoved"
screenState="Launch"
--flags for passing maps
easyPassed=false
mediumPassed=false
hardPassed=false
--counters
hitCounter1=0
hitCounter2=0
perfectCounter1=0
greatCounter1=0
goodCounter1=0
okCounter1=0
missCounter1=1
perfectCounter2=0
greatCounter2=0
goodCounter2=0
okCounter2=0
missCounter2=0
--OOP for easy coding
buttonDimensions={width=80,height=20}
hover={button1=-1,button2=-1,button3=-1}
hoverColour={r=0.8,g=0.8,b=0.8}
titleColour={r=0.3,g=0.3,b=0.3}
titleBright=0
songNameColour={r=0.8,g=0.8,b=0.8}
songNameBright=0
songName="Death By Glamour -- Toby Fox"
screenBrightness=0
-- Editor
notes={}
currentNote=1
bpm=274
editorBpmMin=60
editorBpmMax=300
editorSliderX=-410
editorSliderWidth=240
editorSliderY=-145
editorSliderHeight=16
editorSliderDragging=false
timestamp=0
step=1
increment=0
--initialising for menu
PlayBackgroundMusic=false
PlaySettingsMusic=false
mousePosX=0
mousePosY=0