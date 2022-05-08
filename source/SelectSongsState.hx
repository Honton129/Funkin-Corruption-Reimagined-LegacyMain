package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class SelectSongsState extends MusicBeatState
{	
    var curSelected:Int = 0;
	var bgBack:FlxSprite;
	var bgFront:FlxSprite;
	var extras:FlxSprite;
	var bsides:FlxSprite;
	var mainthing:FlxSprite;
	var extraIndicator:FlxSprite;
	var bsideIndicator:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In The Extra Select", "Selecting Option");
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		persistentUpdate = persistentDraw = true;

		bgBack = new FlxSprite(0, 0).loadGraphic(Paths.image('extrasBG'));
		extraIndicator = new FlxSprite(0, 0).loadGraphic(Paths.image('selectExtras'));
		extraIndicator.antialiasing = true;
		bsideIndicator = new FlxSprite(0, 0).loadGraphic(Paths.image('selectBside'));
		bsideIndicator.antialiasing = true;
		mainthing = new FlxSprite(0, 0).loadGraphic(Paths.image('extrasIcons'));
		add(bgBack);
		add(extraIndicator);
		add(bsideIndicator);
		add(mainthing);

		super.create();
	}

	override function update(elapsed:Float)
	{
        if (curSelected == 1)
            {
                extraIndicator.visible = false;
                bsideIndicator.visible = true;
            }
        else
        {
            extraIndicator.visible = true;
            bsideIndicator.visible = false;
        }        
        if (curSelected > 1)
            {
               curSelected = 0; 
            }
        if (curSelected < 0)
            {
               curSelected = 1; 
            }    
		if (controls.UI_LEFT) {
            curSelected += 1;
            FlxG.sound.play(Paths.sound('scrollMenu'));

        if (controls.UI_RIGHT) {
            curSelected -= 1;
            FlxG.sound.play(Paths.sound('scrollMenu'));
        }
			if (controls.ACCEPT)
			{
				if (curSelected == 0)
                {
                    MusicBeatState.switchState(new ExtraSongsState());
                }
                if (curSelected == 1)
                    {
                        MusicBeatState.switchState(new BsideSongsState());
                    }
			}
            if (controls.BACK)
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    FlxG.switchState(new FreeplayState());
                }
               
		}
        super.update(elapsed);   
	}
}   