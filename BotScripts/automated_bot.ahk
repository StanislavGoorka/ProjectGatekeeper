; AUTOMATED BOT - The User only needs to turn on the bot which will then start and repeat predefined cycle

lureDelay := 500
buffDelay := 2000
afterBuffDelay := 1000
fastDelay := 30
mediumDelay := 200
buffTime := 175
spaceHeld := false

SendMode "Event"

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

LureMobs() {
	global fastDelay
	global lureDelay

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

x:: {

	
}

x up:: {
}

!Esc::ExitApp
