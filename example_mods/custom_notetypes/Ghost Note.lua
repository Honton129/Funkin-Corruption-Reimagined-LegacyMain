function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Ghost Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Ghost Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'ghostNote'); --Change texture
			
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
	--debugPrint('Ghost NOTES BOIS')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, i, noteType, isSustainNote)
	if noteType == 'Ghost Note' then
	playSound('ghostNote', 1);

     end
end