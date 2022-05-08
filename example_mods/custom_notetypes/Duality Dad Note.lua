function goodNoteHit(id,dir,type,sus)
	if type == 'Duality Dad Note' then
		characterPlayAnim('dadDUAL', getProperty('singAnimations')[math.abs(dir)+1], true)
		setProperty('dadDUAL.holdTimer', 0)
	end
end

function opponentNoteHit(id,dir,type,sus)
	if type == 'Duality Dad Note' then
		characterPlayAnim('dadDUAL', getProperty('singAnimations')[math.abs(dir)+1], true)
		setProperty('dadDUAL.holdTimer', 0)
	end
end	