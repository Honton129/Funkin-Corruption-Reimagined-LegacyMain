package;

#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end
import haxe.Json;
import haxe.format.JsonParser;
import Song;

using StringTools;

typedef StageFile = {
	var directory:String;
	var defaultZoom:Float;
	var isPixelStage:Bool;

	var boyfriend:Array<Dynamic>;
	var girlfriend:Array<Dynamic>;
	var opponent:Array<Dynamic>;
}

class StageData {
	public static var forceNextDirectory:String = null;
	public static function loadDirectory(SONG:SwagSong) {
		var stage:String = '';
		if(SONG.stage != null) {
			stage = SONG.stage;
		} else if(SONG.song != null) {
			switch (SONG.song.toLowerCase().replace(' ', '-'))
			{
				case 'spookeez':
					stage = 'spooky';
				case 'xenophobia':
					stage = 'spooky-2';
				case 'killer':
					stage = 'spooky-3';	
				case 'emancipation':
					stage = 'philly';
				case 'gunned-down' | 'gunned down':
					stage = 'philly2';	
				case 'milf' | 'satin-panties' | 'high':
					stage = 'limo';
				case 'cocoa' | 'eggnog':
					stage = 'mall';	
				case 'mayhem' | 'devitalization' | 'devastation':
					stage = 'alleyway';
				case 'winter-horrorland':
					stage = 'mallEvil';
				case 'blissful-ignorance':
					stage = 'school';
				case 'disconnection':
					stage = 'school-2';	
				case 'short-circuit':
					stage = 'school-3';		
				case 'banishment':
					stage = 'schoolEvil';
				case 'bedeviled':
					stage = 'stage-d1';
				case 'affliction':
					stage = 'stage-d2';
				case 'familiar-finale':
					stage = 'stage-d3';	
				case 'tutorial':
					stage = 'stage-d1';							
				default:
					stage = 'stage';
			}
		} else {
			stage = 'stage';
		}

		var stageFile:StageFile = getStageFile(stage);
		if(stageFile == null) { //preventing crashes
			forceNextDirectory = '';
		} else {
			forceNextDirectory = stageFile.directory;
		}
	}

	public static function getStageFile(stage:String):StageFile {
		var rawJson:String = null;
		var path:String = Paths.getPreloadPath('stages/' + stage + '.json');

		#if MODS_ALLOWED
		var modPath:String = Paths.modFolders('stages/' + stage + '.json');
		if(FileSystem.exists(modPath)) {
			rawJson = File.getContent(modPath);
		} else if(FileSystem.exists(path)) {
			rawJson = File.getContent(path);
		}
		#else
		if(Assets.exists(path)) {
			rawJson = Assets.getText(path);
		}
		#end
		else
		{
			return null;
		}
		return cast Json.parse(rawJson);
	}
}