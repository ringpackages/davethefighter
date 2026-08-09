/*
**  Dave the Fighter - HUD & Game State Screens
**  Functions: dave_drawHUD
*/

func dave_drawHUD
    // Skip all HUD drawing when showing the level-select menu
    if gameState = ST_MENU
        dave_drawMenu()
        return
    ok

    // Top bar background
    DrawRectangle(0, 0, SCREEN_W, 44, RAYLIBColor(0, 0, 0, 180))

    // Score
    DrawText("SCORE: " + string(score), 15, 10, 22,
             RAYLIBColor(255, 255, 255, 255))

    // Level number with game name
    lvlText = "Dave the Fighter (Level " + string(level) + ")"
    DrawText(lvlText, floor(SCREEN_W / 2 - MeasureText(lvlText, 22) / 2), 10, 22,
             RAYLIBColor(255, 220, 50, 255))

    // HUD accent bar color matches world
    if level <= 5
        DrawRectangle(0, 44, SCREEN_W, 2, RAYLIBColor(200, 30, 30, 255))
    but level <= 10
        DrawRectangle(0, 44, SCREEN_W, 2, RAYLIBColor(30, 60, 200, 255))
    but level <= 15
        DrawRectangle(0, 44, SCREEN_W, 2, RAYLIBColor(180, 210, 240, 255))
    else
        DrawRectangle(0, 44, SCREEN_W, 2, RAYLIBColor(230, 190, 60, 255))
    ok

    // Lives - draw player face icons
    DrawText("LIVES:", SCREEN_W - 200, 10, 22,
             RAYLIBColor(255, 80, 80, 255))
    for i = 1 to lives
        faceX = SCREEN_W - 120 + (i - 1) * 30
        faceY = 12
        // Face circle (skin)
        DrawCircle(faceX, faceY + 9, 10, RAYLIBColor(255, 200, 150, 255))
        // Hat (red like Dave)
        DrawRectangle(faceX - 10, faceY - 2, 20, 6, RAYLIBColor(220, 40, 40, 255))
        DrawRectangle(faceX - 7, faceY + 3, 14, 3, RAYLIBColor(220, 40, 40, 255))
        // Eyes
        DrawCircle(faceX - 4, faceY + 9, 2, RAYLIBColor(40, 40, 80, 255))
        DrawCircle(faceX + 4, faceY + 9, 2, RAYLIBColor(40, 40, 80, 255))
        // Smile
        DrawRectangle(faceX - 3, faceY + 14, 6, 2, RAYLIBColor(180, 80, 80, 255))
    next

    // Key indicator
    if hasKey
        DrawText("[KEY]", SCREEN_W - 280, 10, 22,
                 RAYLIBColor(255, 220, 50, 255))
    ok

    // Gun indicator
    if hasGun
        gunX = SCREEN_W - 360
        DrawText("[GUN]", gunX, 10, 22,
                 RAYLIBColor(255, 140, 30, 255))
    ok

    // Gems progress
    collected = totalGems - gemsLeft
    progText = "Gems: " + string(collected) + "/" + string(totalGems)
    DrawText(progText, 15, SCREEN_H - 30, 18,
             RAYLIBColor(100, 200, 255, 200))

    // Popups (2D overlay text)
    nPopups = len(popups)
    for i = 1 to nPopups
        // TODO: could project 3D to 2D for popup text
    next

    // State overlays
    if gameState = ST_PAUSED
        DrawRectangle(0, 0, SCREEN_W, SCREEN_H, RAYLIBColor(0, 0, 0, 160))
        pTxt = "PAUSED"
        DrawText(pTxt, floor(SCREEN_W / 2 - MeasureText(pTxt, 48) / 2),
                 floor(SCREEN_H / 2 - 24), 48, RAYLIBColor(255, 255, 255, 255))
        rTxt = "Press P to Resume"
        DrawText(rTxt, floor(SCREEN_W / 2 - MeasureText(rTxt, 22) / 2),
                 floor(SCREEN_H / 2 + 30), 22, RAYLIBColor(200, 200, 200, 200))
    ok

    if gameState = ST_GAMEOVER
        DrawRectangle(0, 0, SCREEN_W, SCREEN_H, RAYLIBColor(0, 0, 0, 200))
        goTxt = "GAME OVER"
        DrawText(goTxt, floor(SCREEN_W / 2 - MeasureText(goTxt, 52) / 2),
                 floor(SCREEN_H / 2 - 50), 52, RAYLIBColor(255, 30, 30, 255))
        sTxt = "Final Score: " + string(score)
        DrawText(sTxt, floor(SCREEN_W / 2 - MeasureText(sTxt, 26) / 2),
                 floor(SCREEN_H / 2 + 10), 26, RAYLIBColor(255, 200, 100, 255))
        rr = "Press ENTER to Return to Title"
        DrawText(rr, floor(SCREEN_W / 2 - MeasureText(rr, 20) / 2),
                 floor(SCREEN_H / 2 + 50), 20, RAYLIBColor(200, 200, 200, 200))
    ok

    if gameState = ST_WON
        DrawRectangle(0, 0, SCREEN_W, SCREEN_H, RAYLIBColor(0, 0, 0, 200))
        wTxt = "YOU WIN!"
        DrawText(wTxt, floor(SCREEN_W / 2 - MeasureText(wTxt, 56) / 2),
                 floor(SCREEN_H / 2 - 50), 56, RAYLIBColor(255, 220, 50, 255))
        sTxt2 = "Final Score: " + string(score)
        DrawText(sTxt2, floor(SCREEN_W / 2 - MeasureText(sTxt2, 28) / 2),
                 floor(SCREEN_H / 2 + 10), 28, RAYLIBColor(255, 255, 200, 255))
        cTxt = "Congratulations, Fighter Dave!"
        DrawText(cTxt, floor(SCREEN_W / 2 - MeasureText(cTxt, 22) / 2),
                 floor(SCREEN_H / 2 + 50), 22, RAYLIBColor(200, 200, 200, 220))
        rr2 = "Press ENTER to Return to Title"
        DrawText(rr2, floor(SCREEN_W / 2 - MeasureText(rr2, 20) / 2),
                 floor(SCREEN_H / 2 + 90), 20, RAYLIBColor(180, 180, 180, 180))
    ok

    if gameState = ST_LEVELUP
        prog = 1.0 - (levelUpTimer / 2.0)
        alpha = floor(prog * 255)
        if alpha > 255 alpha = 255 ok
        DrawRectangle(0, 0, SCREEN_W, SCREEN_H, RAYLIBColor(0, 0, 0, floor(alpha * 0.6)))
        lTxt = "LEVEL " + string(level) + " COMPLETE!"
        DrawText(lTxt, floor(SCREEN_W / 2 - MeasureText(lTxt, 44) / 2),
                 floor(SCREEN_H / 2 - 22), 44, RAYLIBColor(255, 220, 50, alpha))
    ok

    if gameState = ST_DYING
        prog = 1.0 - (dyingTimer / 1.5)
        alpha = floor(prog * 180)
        DrawRectangle(0, 0, SCREEN_W, SCREEN_H, RAYLIBColor(255, 0, 0, alpha))
    ok

    // FPS
    // DrawFPS(SCREEN_W - 80, 50)

    // Level 20 story messages
    if level = 20 and gameState = ST_PLAYING
        dave_drawLevel20Messages()
    ok

func dave_drawLevel20Messages
    msg = ""
    msg2 = ""
    msgColor = RAYLIBColor(255, 255, 255, 255)
    showMsg = false

    // Message 1: cols 15-28 - Empty prison, eerie silence
    if px >= 15 and px < 29
        msg = "There is no key in this level."
        msgColor = RAYLIBColor(255, 200, 50, 255)
        showMsg = true
    ok

    // Message 2: cols 30-43
    if px >= 30 and px < 44
        msg = "Life is not fair."
        msg2 = "You cannot win. You cannot finish this game."
        msgColor = RAYLIBColor(255, 100, 100, 255)
        showMsg = true
    ok

    // Message 3: cols 45-58
    if px >= 45 and px < 59
        msg = "You have killed many NPCs in this game."
        msg2 = "Now it is time for justice."
        msgColor = RAYLIBColor(255, 80, 80, 255)
        showMsg = true
    ok

    // Message 4: cols 60-73
    if px >= 60 and px < 74
        msg = "You will remain in this prison forever!"
        msgColor = RAYLIBColor(200, 50, 50, 255)
        showMsg = true
    ok

    // Message 5: cols 75-88
    if px >= 75 and px < 89
        msg = "There is only one way out of this world..."
        msg2 = "Are you the Prince of Vibe Code?"
        msgColor = RAYLIBColor(100, 200, 255, 255)
        showMsg = true
    ok

    // Message 6: cols 89-100 - The answer
    if px >= 89 and px < 101
        if !hasKey
            msg = "Claim your Ring to say Yes!"
            msgColor = RAYLIBColor(255, 220, 50, 255)
            showMsg = true
        else
            msg = "You now have the key!"
            msg2 = "Find the door and escape!"
            msgColor = RAYLIBColor(50, 255, 100, 255)
            showMsg = true
        ok
    ok

    // After collecting key
    if px >= 101 and hasKey
        msg = "Freedom awaits you!"
        msgColor = RAYLIBColor(50, 255, 100, 255)
        showMsg = true
    ok

    if showMsg
        // Dark overlay behind text
        DrawRectangle(floor(SCREEN_W / 2 - 350), floor(SCREEN_H / 2 - 60),
                      700, 120, RAYLIBColor(0, 0, 0, 180))
        DrawRectangleLines(floor(SCREEN_W / 2 - 350), floor(SCREEN_H / 2 - 60),
                           700, 120, msgColor)

        // Main message
        pulse = floor(sin(animTime * 2.0) * 30 + 225)
        sz = 28
        DrawText(msg, floor(SCREEN_W / 2 - MeasureText(msg, sz) / 2),
                 floor(SCREEN_H / 2 - 30), sz, msgColor)

        // Second line if present
        if len(msg2) > 0
            sz2 = 24
            DrawText(msg2, floor(SCREEN_W / 2 - MeasureText(msg2, sz2) / 2),
                     floor(SCREEN_H / 2 + 10), sz2, msgColor)
        ok
    ok

// =============================================================
// Gameplay Background Stars (void outside the level walls/ceiling)
// =============================================================

func dave_initGameStars
    if gsInitialized return ok
    for i = 1 to GAME_STAR_MAX
        gsX[i] = GetRandomValue(0, SCREEN_W)
        gsY[i] = GetRandomValue(0, SCREEN_H)
        gsPhase[i] = GetRandomValue(0, 628) / 100.0
        gsSpeed[i] = GetRandomValue(15, 45) / 10.0
        gsBright[i] = GetRandomValue(120, 255)
        gsSz[i] = GetRandomValue(10, 22) / 10.0
    next
    gsInitialized = true

func dave_drawBackgroundStars
    dave_initGameStars()

    // Project the opaque level background wall to screen space so stars are
    // only drawn where the wall does NOT cover - i.e. the true void beyond
    // the level's edges/ceiling.
    wz = -0.9
    p1 = GetWorldToScreen(Vector3(-1.0, -1.0, wz), cam)
    p2 = GetWorldToScreen(Vector3(-1.0, LVL_H + 1.0, wz), cam)
    p3 = GetWorldToScreen(Vector3(curLvlW + 1.0, -1.0, wz), cam)
    p4 = GetWorldToScreen(Vector3(curLvlW + 1.0, LVL_H + 1.0, wz), cam)

    wallMinX = p1.x  wallMaxX = p1.x
    wallMinY = p1.y  wallMaxY = p1.y
    for pt in [p2, p3, p4]
        if pt.x < wallMinX wallMinX = pt.x ok
        if pt.x > wallMaxX wallMaxX = pt.x ok
        if pt.y < wallMinY wallMinY = pt.y ok
        if pt.y > wallMaxY wallMaxY = pt.y ok
    next

    for i = 1 to GAME_STAR_MAX
        sx = gsX[i]
        sy = gsY[i]
        // Skip stars that fall over the opaque level area
        if sx > wallMinX and sx < wallMaxX and sy > wallMinY and sy < wallMaxY
            loop
        ok

        bright = sin(animTime * gsSpeed[i] + gsPhase[i])
        alpha = floor((bright + 1.0) * 0.5 * gsBright[i])
        if alpha > 255 alpha = 255 ok
        if alpha < 15 alpha = 15 ok

        sz = gsSz[i]
        DrawCircle(floor(sx), floor(sy), floor(sz * 2.5),
                   RAYLIBColor(180, 205, 255, floor(alpha * 0.2)))
        DrawCircle(floor(sx), floor(sy), floor(sz),
                   RAYLIBColor(220, 235, 255, alpha))
        if bright > 0.7
            DrawCircle(floor(sx), floor(sy), floor(sz * 0.4),
                       RAYLIBColor(255, 255, 255, floor(alpha * 0.8)))
        ok
    next

// =============================================================
// Combined Welcome + Level-Select Screen
// =============================================================

# Decorative gradient border frame around the welcome screen, in the style of
# povc.ring's notification borders (drawFancyBorder) but drawn with plain
# raylib primitives instead of the border PNG.
func drawScreenBorder gradCol1, gradCol2, outerCol, innerCol
    inset = 14   thick = 5
    DrawRectangleGradientH(inset, inset, SCREEN_W-inset*2, thick, gradCol1, gradCol2)
    DrawRectangleGradientH(inset, SCREEN_H-inset-thick, SCREEN_W-inset*2, thick, gradCol2, gradCol1)
    DrawRectangleGradientV(inset, inset, thick, SCREEN_H-inset*2, gradCol1, gradCol2)
    DrawRectangleGradientV(SCREEN_W-inset-thick, inset, thick, SCREEN_H-inset*2, gradCol1, gradCol2)
    DrawRectangleLines(inset-3, inset-3, SCREEN_W-(inset-3)*2, SCREEN_H-(inset-3)*2, outerCol)
    DrawRectangleLines(inset+thick+4, inset+thick+4, SCREEN_W-(inset+thick+4)*2, SCREEN_H-(inset+thick+4)*2, innerCol)

# Shared layout math for the combined welcome/level-select screen, used by
# both dave_drawMenu (drawing) and dave_handleMenuInput (mouse hit-testing)
# so they can never drift apart. Fonts scale with the monitor's actual
# resolution (baseline = 700px tall), and the whole block -- title, subtitle,
# guidelines, level grid, close button -- is vertically centered based on its
# real computed content height.
func dave_computeMenuLayout
    mY = SCREEN_H / 700.0

    dave_titleSz = max(34, floor(64*mY))
    dave_ctrlSz  = max(12, floor(16*mY))
    dave_selLblSz= max(15, floor(22*mY))

    dave_lvlSz   = max(18, floor(28*mY))
    dave_btnLblSz = max(15, floor(22*mY))
    dave_btnW = max(floor(100*mY), MeasureText("CLOSE GAME", dave_btnLblSz) + 30)
    dave_btnH = floor(50*mY)

    dave_cardW = max(floor(90*mY), MeasureText(string(maxLevel - 1), dave_lvlSz) + 30)
    dave_cardH = dave_btnH        // same height as the Close button
    dave_gapX  = floor(20*mY)
    dave_gapY  = floor(16*mY)

    gap1 = floor(14*mY)   // title -> controls
    gap3 = floor(16*mY)   // controls -> "SELECT LEVEL" label
    gap4 = floor(10*mY)   // label -> grid
    gap5 = floor(14*mY)   // grid -> close button

    titleBlockH = dave_titleSz + floor(10*mY)
    ctrlBlockH  = dave_ctrlSz   // 1 line
    selLblBlockH = dave_selLblSz
    dave_gridH = 4 * dave_cardH + 3 * dave_gapY
    btnBlockH  = dave_btnH

    contentH = titleBlockH+gap1+ctrlBlockH+gap3+selLblBlockH+gap4+dave_gridH+gap5+btnBlockH

    topY = floor((SCREEN_H - contentH) / 2)
    if topY < floor(14*mY)  topY = floor(14*mY)  ok

    dave_titleY  = topY
    dave_ctrlY1  = dave_titleY + titleBlockH + gap1
    dave_selLblY = dave_ctrlY1 + ctrlBlockH + gap3
    dave_startY  = dave_selLblY + selLblBlockH + gap4
    dave_btnY    = dave_startY + dave_gridH + gap5

    totalGridW = 5 * dave_cardW + 4 * dave_gapX
    dave_startX = floor((SCREEN_W - totalGridW) / 2)
    dave_btnX   = floor((SCREEN_W - dave_btnW) / 2)

func dave_drawMenu
    dave_computeMenuLayout()

    // Menu background image
    DrawTexturePro(dave_menuBackTex,
        Rectangle(0.0, 0.0, dave_menuBackTex.width*1.0, dave_menuBackTex.height*1.0),
        Rectangle(0.0, 0.0, SCREEN_W*1.0, SCREEN_H*1.0),
        Vector2(0.0, 0.0), 0.0, WHITE)

    // Title (with a gentle wobble/bounce, drop-shadow copy underneath)
    wob = floor(sin(animTime * 2.0) * 8)
    title = "Dave the Fighter"
    tW = MeasureText(title, dave_titleSz)
    tX = floor((SCREEN_W - tW) / 2)
    DrawText(title, tX + 3, dave_titleY + 3 + wob, dave_titleSz, RAYLIBColor(0, 20, 10, 200))
    DrawText(title, tX, dave_titleY + wob, dave_titleSz, WHITE)

    ctrl1 = "Arrows/WASD: Move  |  W/Up: Jump  |  F/Space: Shoot (Gun Required)"
    DrawText(ctrl1, floor(SCREEN_W/2 - MeasureText(ctrl1, dave_ctrlSz)/2), dave_ctrlY1,
             dave_ctrlSz, RAYLIBColor(180, 220, 180, 200))

    selLbl = "SELECT LEVEL"
    DrawText(selLbl, floor(SCREEN_W/2 - MeasureText(selLbl, dave_selLblSz)/2), dave_selLblY,
             dave_selLblSz, RAYLIBColor(180, 220, 180, 200))

    cols = 5
    cardW = dave_cardW  cardH = dave_cardH
    gapX  = dave_gapX   gapY  = dave_gapY
    startX = dave_startX  startY = dave_startY

    for i = 1 to maxLevel - 1
        row   = floor((i - 1) / cols)
        col   = (i - 1) % cols
        cx    = startX + col * (cardW + gapX)
        cy    = startY + row * (cardH + gapY)

        isActive   = (i = menuSelectedLevel)

        // Card: navy bg + light-blue text normally; light-blue bg + navy text when highlighted
        if isActive
            DrawRectangleGradientV(cx, cy, cardW, cardH, RAYLIBColor(210, 235, 248, 255), RAYLIBColor(140, 190, 218, 255))
            DrawRectangleLines(cx, cy, cardW, cardH, RAYLIBColor(0, 0, 80, 255))
            cardTextCol = RAYLIBColor(0, 0, 80, 255)
        else
            DrawRectangleGradientV(cx, cy, cardW, cardH, RAYLIBColor(25, 35, 45, 255), RAYLIBColor(12, 18, 25, 255))
            DrawRectangleLines(cx, cy, cardW, cardH, RAYLIBColor(173, 216, 230, 255))
            cardTextCol = RAYLIBColor(173, 216, 230, 255)
        ok

        // Level number
        lvlStr = string(i)
        lW     = MeasureText(lvlStr, dave_lvlSz)
        DrawText(lvlStr, cx + floor((cardW - lW) / 2), cy + floor((cardH - dave_lvlSz) / 2), dave_lvlSz, cardTextCol)
    next

    // Close button
    btnW = dave_btnW  btnH = dave_btnH
    btnX = dave_btnX  btnY = dave_btnY

    btnActive = (menuSelectedLevel = CLOSE_BTN)
    if btnActive
        DrawRectangleGradientV(btnX, btnY, btnW, btnH, RAYLIBColor(210, 235, 248, 255), RAYLIBColor(140, 190, 218, 255))
        DrawRectangleLines(btnX, btnY, btnW, btnH, RAYLIBColor(0, 0, 80, 255))
        btnTextCol = RAYLIBColor(0, 0, 80, 255)
    else
        DrawRectangleGradientV(btnX, btnY, btnW, btnH, RAYLIBColor(25, 35, 45, 255), RAYLIBColor(12, 18, 25, 255))
        DrawRectangleLines(btnX, btnY, btnW, btnH, RAYLIBColor(173, 216, 230, 255))
        btnTextCol = RAYLIBColor(173, 216, 230, 255)
    ok
    closeStr = "CLOSE GAME"
    DrawText(closeStr, btnX + floor((btnW - MeasureText(closeStr, dave_btnLblSz)) / 2),
             btnY + floor((btnH - dave_btnLblSz) / 2), dave_btnLblSz, btnTextCol)

    drawScreenBorder(RAYLIBColor(8,60,30,235), RAYLIBColor(3,25,12,235), RAYLIBColor(173,216,230,255), RAYLIBColor(173,216,230,70))
