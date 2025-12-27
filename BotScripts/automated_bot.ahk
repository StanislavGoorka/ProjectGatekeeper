; AUTOMATED BOT - The User only needs to turn on the bot which will then start and repeat predefined cycle

lureDelay := 500
buffDelay := 2000
afterBuffDelay := 1000
fastDelay := 30
mediumDelay := 200
cycleTime := 175
cycleTimeLeft := cycleTime
lureInterval := 30000
isBotRunning := false
isLureTimerRunning := false

SendMode "Event"

overlay := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
overlay.BackColor := "Black"
overlay.SetFont("s14 cWhite", "Segoe UI")

txt := overlay.Add("Text", "BackgroundTrans", cycleTimeLeft)

overlay.Show("x20 y20 NoActivate")


RandomizeDelay(baseDelay) {
	multiplier := Random()
	randomDelay := baseDelay + baseDelay / 2 * multiplier

	return randomDelay
}

UseHorse() {
	global fastDelay
	global mediumDelay

	Send "{Ctrl down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{h down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{h up}"
	Sleep RandomizeDelay(fastDelay)
	Send "{Ctrl up}"
	Sleep RandomizeDelay(mediumDelay)
}

LureMobs(*) {
	global fastDelay
	global lureDelay
	global cycleTimeLeft

	if (cycleTimeLeft <= 30) {
		return
	}

	Send "{F4 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F4 up}"

	Sleep RandomizeDelay(lureDelay)

	Send "{F4 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F4 up}"

	Sleep RandomizeDelay(lureDelay)

	Send "{F4 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F4 up}"
}

StartFight() {
	Send "{Space down}"
	SetTimer(GatherItem, 1000)
}

EndFight() {
	Send "{Space up}"
	SetTimer(GatherItem, 0)
}

GatherItem(*) {
	Send "{z down}"
	Send "{z up}"
}

ApplyBuffs() {
	global fastDelay
	global buffDelay
	global afterBuffDelay
	global cycleTime
	global cycleTimeLeft

	Send "{F1 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F1 up}"

	Sleep RandomizeDelay(buffDelay)

	Send "{F2 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F2 up}"

	Sleep RandomizeDelay(buffDelay)

	Send "{F3 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F3 up}"

	Sleep RandomizeDelay(afterBuffDelay)

	cycleTimeLeft := cycleTime
	SetTimer(TimerTick, 1000)
}

RemoveBuffs() {
	global fastDelay

	Send "{F1 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F1 up}"

	Sleep RandomizeDelay(fastDelay)

	Send "{F2 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F2 up}"

	Sleep RandomizeDelay(fastDelay)

	Send "{F3 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F3 up}"

	Sleep RandomizeDelay(fastDelay)
}

RefreshBonuses() {
	global fastDelay

	Send "{Ctrl down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 up}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 up}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 down}"
	Sleep RandomizeDelay(fastDelay)
	Send "{F7 up}"
	Sleep RandomizeDelay(fastDelay)
	Send "{Ctrl up}"
	Sleep RandomizeDelay(fastDelay)
}

TimerTick(*) {
	global cycleTimeLeft
	global txt

	txt.Text := --cycleTimeLeft
}

CycleStateMachine(*) {
	global cycleTime
	global cycleTimeLeft
	global lureInterval
	global isBotRunning
	global isLureTimerRunning

	if (!isBotRunning) {
		UseHorse()
		if (cycleTimeLeft >= 0) {
			RemoveBuffs()
		}
		ApplyBuffs()
		UseHorse()
		RefreshBonuses()
		StartFight()
		LureMobs()
	} else if (!isLureTimerRunning) {
		SetTimer(LureMobs, lureInterval)
		isLureTimerRunning := true
	}

	if (cycleTimeLeft < 10 && cycleTimeLeft >= 0) {
		SetTimer(LureMobs, 0)
		isLureTimerRunning := false
		EndFight()
		UseHorse()
		RemoveBuffs()
		ApplyBuffs()
		UseHorse()
		RefreshBonuses()
		StartFight()
		LureMobs()
	}
}

x:: {
	global isBotRunning
	global isLureTimerRunning
	global cycleTimeLeft

	if (!isBotRunning) {
		SetTimer(CycleStateMachine, 100)
		Sleep 200
		isBotRunning := true
	} else {
		SetTimer(CycleStateMachine, 0)
		isBotRunning := false

		SetTimer(LureMobs, 0)
		isLureTimerRunning := false

		EndFight()
	}
}

x up:: {
}

!Esc::ExitApp
