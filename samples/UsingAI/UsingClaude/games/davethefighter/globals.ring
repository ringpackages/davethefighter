/*
**  Dave the Fighter - Global Variables
**  Game state, player, level data, enemies, bullets, particles, timers, sound
*/

// Game state
gameState       = ST_MENU
quitGame        = false
level           = 1
maxLevel        = 20
menuSelectedLevel = 1
menuLastHover     = -1   // tracks last hovered menu item; -1 = none
menuLastMouseX    = -1   // tracks last mouse X to detect movement
menuLastMouseY    = -1   // tracks last mouse Y to detect movement
menuPressX        = -1   // mouse X when left button was first pressed
menuPressY        = -1   // mouse Y when left button was first pressed
menuPressHover    = -1   // hovered item index at press time

// Combined welcome + level-select screen layout (computed by
// dave_computeMenuLayout; shared between dave_drawMenu and
// dave_handleMenuInput so the drawn geometry and the hit-testing
// geometry can never drift apart).
dave_titleSz=0 dave_titleY=0
dave_ctrlSz=0  dave_ctrlY1=0
dave_selLblSz=0 dave_selLblY=0
dave_cardW=0 dave_cardH=0 dave_gapX=0 dave_gapY=0
dave_lvlSz=0
dave_startX=0 dave_startY=0 dave_gridH=0
dave_btnLblSz=0 dave_btnW=0 dave_btnH=0 dave_btnX=0 dave_btnY=0
score           = 0
lives           = 3
hasKey          = false
doorOpen        = false
hasGun          = false

// Current level width (set per level)
curLvlW         = LVL_W

// Player
px              = 2.0
py              = 12.0
pvx             = 0.0
pvy             = 0.0
pOnGround       = false
pOnLadder       = false
pClimbFrame     = 0.0
pFacingRight    = true
pAnimTime       = 0.0
pWalkFrame      = 0.0
pShootCooldown  = 0.0
pOnMover        = false

// Checkpoint
checkpointX     = -1
checkpointY     = -1
checkpointActive = false

// Camera
camMode         = CAM_SIDE
cam             = NULL

// Level data
tiles           = []
gemsLeft        = 0
totalGems       = 0

// Moving platforms: [x, y, vx, vy, rangeMin, rangeMax, type(H/V), width]
movers          = []

// Falling icicles: [x, y, state(0=hanging,1=shaking,2=falling,3=gone), shakeTimer, vy]
icicles         = []

// Crumbling platforms: [col, row, timer, state(0=solid,1=crumbling,2=gone)]
crumbles        = []

// Wind zones: [col, row, direction(-1=left,+1=right)]
windZones       = []

// Enemies: [x, y, vx, vy, type, alive, animT, shootTimer]
enemies         = []

// Player bullets: [x, y, vx, vy, life]
bullets         = []

// Enemy bullets: [x, y, vx, vy, life]
eBullets        = []

// Particles: [x, y, vx, vy, life, maxLife, r, g, b, size]
particles       = []

// Popups: [x, y, text, life]
popups          = []

// Timer
animTime        = 0.0
dyingTimer      = 0.0
levelUpTimer    = 0.0

// Sound effects and music
sndJump         = NULL
sndGem          = NULL
sndRuby         = NULL
sndRing         = NULL
sndKey          = NULL
sndDoor         = NULL
sndTrophy       = NULL
sndShoot        = NULL
sndEnemyShoot   = NULL
sndEnemyDie     = NULL
sndHurt         = NULL
sndGunPickup    = NULL
bgMusic         = NULL

// Gameplay background starfield (2D screen-space, drawn only in the void
// beyond the level's on-screen edges/ceiling - see dave_drawBackgroundStars)
GAME_STAR_MAX = 100
gsInitialized = false
gsX     = list(GAME_STAR_MAX)
gsY     = list(GAME_STAR_MAX)
gsPhase = list(GAME_STAR_MAX)
gsSpeed = list(GAME_STAR_MAX)
gsBright = list(GAME_STAR_MAX)
gsSz    = list(GAME_STAR_MAX)

