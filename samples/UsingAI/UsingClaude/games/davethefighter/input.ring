/*
**  Dave the Fighter - Input Handling
**  Functions: dave_handleInput, dave_handleMenuInput
*/

func dave_handleInput dt

    // Restart
    if IsKeyPressed(KEY_R)
        dave_loadLevel(level)
        gameState = ST_PLAYING
        return
    ok

    // Next level (N)
    if IsKeyPressed(KEY_N)
        if level < maxLevel
            level += 1
            dave_loadLevel(level)
            gameState = ST_PLAYING
        ok
        return
    ok

    // Previous level (B)
    if IsKeyPressed(KEY_B)
        if level > 1
            level -= 1
            dave_loadLevel(level)
            gameState = ST_PLAYING
        ok
        return
    ok

    if gameState = ST_MENU
        dave_handleMenuInput()
        return
    ok

    if gameState = ST_GAMEOVER or gameState = ST_WON
        if IsKeyPressed(KEY_ENTER) or IsKeyPressed(KEY_SPACE)
            gameState = ST_MENU
            ShowCursor()
        ok
        return
    ok

    if gameState = ST_PLAYING
        if IsKeyPressed(KEY_P)
            gameState = ST_PAUSED
            PauseMusicStream(bgMusic)
            return
        ok
        if IsKeyPressed(KEY_ESCAPE)
            menuSelectedLevel = level
            gameState = ST_MENU
            ShowCursor()
            return
        ok
    ok

    if gameState = ST_PAUSED
        if IsKeyPressed(KEY_P) or IsKeyPressed(KEY_SPACE)
            gameState = ST_PLAYING
            ResumeMusicStream(bgMusic)
        ok
        return
    ok

    if gameState != ST_PLAYING return ok

    // Movement
    moveDir = 0
    if IsKeyDown(KEY_LEFT) or IsKeyDown(KEY_A)
        moveDir = -1
        pFacingRight = false
    ok
    if IsKeyDown(KEY_RIGHT) or IsKeyDown(KEY_D)
        moveDir = 1
        pFacingRight = true
    ok

    // Acceleration
    if moveDir != 0
        pvx = moveDir * MOVE_SPEED
        pWalkFrame += dt * 8.0
    else
        pvx = pvx * 0.7
        if pvx > -0.3 and pvx < 0.3 pvx = 0 ok
    ok

    // Jump
    if IsKeyPressed(KEY_UP) or IsKeyPressed(KEY_W)
        if pOnGround
            pvy = JUMP_FORCE
            pOnGround = false
            PlaySound(sndJump)
        ok
    ok

    // Ladder climbing
    tr = dave_tileAtWorld(px, py)
    trBody = dave_tileAtWorld(px, py + 0.3)
    trBelow = dave_tileAtWorld(px, py - 0.3)
    onLadderTile = (tr = T_LADDER or trBody = T_LADDER)

    if onLadderTile and !pOnGround
        // Already inside a ladder and not on ground - climb freely
        if IsKeyDown(KEY_UP) or IsKeyDown(KEY_W)
            pvy = 3.5
            pOnGround = false
        ok
        if IsKeyDown(KEY_DOWN) or IsKeyDown(KEY_S)
            pvy = -3.5
        ok
    but onLadderTile and pOnGround
        // Standing on a ladder tile that acts as ground (converted from brick)
        if IsKeyDown(KEY_DOWN) or IsKeyDown(KEY_S)
            py -= 0.5
            pvy = -2.5
            pOnGround = false
        ok
        if IsKeyDown(KEY_UP) or IsKeyDown(KEY_W)
            pvy = 3.5
            pOnGround = false
        ok
    but trBelow = T_LADDER and pOnGround
        // Standing on solid ground above a ladder - press down to enter
        if IsKeyDown(KEY_DOWN) or IsKeyDown(KEY_S)
            py -= 0.5
            pvy = -2.5
            pOnGround = false
        ok
    ok

    // Shooting
    if hasGun and pShootCooldown <= 0
        if IsKeyPressed(KEY_F) or IsKeyPressed(KEY_SPACE)
            bDir = 1
            if !pFacingRight bDir = -1 ok
            add(bullets, [px + bDir * 0.3, py + 0.5, bDir * 14.0, 0.0, 1.5])
            pShootCooldown = 0.25
            dave_spawnPickupParticles(px + bDir * 0.3, py + 0.5, 255, 200, 50)
            PlaySound(sndShoot)
        ok
    ok

// =============================================================
// Level-Select Menu Input
// =============================================================

func dave_handleMenuInput
    prevSel = menuSelectedLevel

    // Keyboard navigation (arrow keys move through the 4×5 grid + Close button)
    if IsKeyPressed(KEY_RIGHT) or IsKeyPressed(KEY_D)
        if menuSelectedLevel < maxLevel - 1
            menuSelectedLevel += 1
        ok
    ok
    if IsKeyPressed(KEY_LEFT) or IsKeyPressed(KEY_A)
        if menuSelectedLevel > 1 and menuSelectedLevel != CLOSE_BTN
            menuSelectedLevel -= 1
        ok
    ok
    if IsKeyPressed(KEY_DOWN) or IsKeyPressed(KEY_S)
        if menuSelectedLevel <= 15
            menuSelectedLevel += 5
        but menuSelectedLevel <= maxLevel - 1
            // Row 4 (16-19) → Close button
            menuSelectedLevel = CLOSE_BTN
        ok
    ok
    if IsKeyPressed(KEY_UP) or IsKeyPressed(KEY_W)
        if menuSelectedLevel = CLOSE_BTN
            // Close button → back to row 4 (same column: centre = 18)
            menuSelectedLevel = 18
        but menuSelectedLevel > 5
            menuSelectedLevel -= 5
        ok
    ok

    // Confirm selection
    if IsKeyPressed(KEY_ENTER) or IsKeyPressed(KEY_SPACE)
        if menuSelectedLevel = CLOSE_BTN
            quitGame = true
            return
        ok
        level = menuSelectedLevel
        score = 0
        lives = 3
        dave_loadLevel(level)
        gameState = ST_PLAYING
        HideCursor()
        return
    ok

    // ESC closes the game
    if IsKeyPressed(KEY_ESCAPE)
        quitGame = true
        return
    ok

    // Mouse hover & click
    dave_computeMenuLayout()
    mx = GetMouseX()
    my = GetMouseY()

    cols   = 5
    cardW  = dave_cardW
    cardH  = dave_cardH
    gapX   = dave_gapX
    gapY   = dave_gapY
    startX = dave_startX
    startY = dave_startY

    // Detect which item the mouse is over this frame
    newHover = -1
    for i = 1 to maxLevel - 1
        row = floor((i - 1) / cols)
        col = (i - 1) % cols
        cx  = startX + col * (cardW + gapX)
        cy  = startY + row * (cardH + gapY)
        if mx >= cx and mx < cx + cardW and my >= cy and my < cy + cardH
            newHover = i
        ok
    next

    // Close button hover
    btnW  = dave_btnW
    btnH  = dave_btnH
    btnX  = dave_btnX
    btnY  = dave_btnY
    if mx >= btnX and mx < btnX + btnW and my >= btnY and my < btnY + btnH
        newHover = CLOSE_BTN
    ok

    // Track press position and which button was under the cursor at press time
    if IsMouseButtonPressed(0)
        menuPressX     = mx
        menuPressY     = my
        menuPressHover = newHover
    ok

    // Sync selection when mouse enters a new item OR moves within the current item
    mouseMoved = (mx != menuLastMouseX or my != menuLastMouseY)
    if newHover >= 0 and (newHover != menuLastHover or mouseMoved)
        menuSelectedLevel = newHover
    ok
    menuLastHover  = newHover
    menuLastMouseX = mx
    menuLastMouseY = my

    // Click fires only when released over the same button that was pressed
    if IsMouseButtonReleased(0) and newHover >= 0 and newHover = menuPressHover
        if menuSelectedLevel = CLOSE_BTN
            quitGame = true
            return
        ok
        level = menuSelectedLevel
        score = 0
        lives = 3
        dave_loadLevel(level)
        gameState = ST_PLAYING
        HideCursor()
        return
    ok

    // Play gem sound whenever selection changes
    if menuSelectedLevel != prevSel
        PlaySound(sndGem)
    ok
