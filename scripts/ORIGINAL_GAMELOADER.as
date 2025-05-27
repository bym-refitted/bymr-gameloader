package
{
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;

   /*
    * The original preserved gameloader class responsible for loading and initializing the main game SWF.
    * Displays a loading progress bar while preparing the game.
    */
    public class GAMELOADER extends Sprite
    {

        public var mcLoading:MovieClip;

        public var _vars:Object;

        public var _game:Loader;

        public function GAMELOADER()
        {
            super();
            if (ExternalInterface.available)
            {
                ExternalInterface.call("cc.recordStats", "loaderend");
            }
            this._vars = stage.root.loaderInfo.parameters;
            this._game = new Loader();
            if (this._vars.apiurl == undefined)
            {
                this._vars._baseURL = "http://bm.lb3.fb.casualcollective.com/api/";
                this._vars._apiURL = "http://bm.lb3.fb.casualcollective.com/api/";
                this._vars._gameURL = "";
                this._vars._statsURL = "http://bm.lb3.fb.casualcollective.com/recordstats.php";
                this._vars._storageURL = "assets/";
                this._vars._soundPathURL = "assets/sounds/";
                this._vars._mapURL = "http://bm.lb3.fb.casualcollective.com/";
                this._vars._appid = "191772264192545";
                this._vars._tpid = "wV805-dynPPTskA6rS4ChuHkkWE";
                this._vars._countryCode = "us";
                this._vars._allianceURL = "http://bm.lb3.fb.casualcollective.com/alliance/";
                this._game.load(new URLRequest("game.swf"));
            }
            else
            {
                this._vars._baseURL = this._vars.baseurl;
                this._vars._apiURL = this._vars.apiurl;
                this._vars._gameURL = this._vars.gameurl;
                this._vars._storageURL = this._vars.gameurl + "assets/";
                this._vars._soundPathURL = this._vars.gameurl + "assets/sounds/";
                this._vars._statsURL = this._vars.statsurl;
                this._vars._mapURL = this._vars.mapurl;
                this._vars._appid = this._vars.app_id;
                this._vars._tpid = this._vars.tpid;
                this._vars._countryCode = this._vars.ccode;
                this._vars._allianceURL = this._vars.allianceurl;
                this._game.load(new URLRequest(this._vars._gameURL + "game-v" + this._vars.gameversion + ".v" + this._vars.softversion + ".swf"));
            }
            this._game.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            this._game.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.mcLoading.tProgress.htmlText = "0%";
            this.mcLoading.mcLoadingScreen.mcBar.width = 0;
            if (ExternalInterface.available)
            {
                ExternalInterface.call("cc.recordStats", "gamestart");
            }
        }

        public function onProgress(e:ProgressEvent):void
        {
            var pct:* = Math.floor(100 * e.bytesLoaded / e.bytesTotal);
            this.mcLoading.tProgress.htmlText = pct + "%";
            this.mcLoading.mcLoadingScreen.mcBar.width = pct * 2.4;
        }

        public function onComplete(e:Event):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("cc.recordStats", "gameend");
            }
            removeChild(this.mcLoading);
            this.mcLoading = null;
            addChild(this._game);
            Object(this._game.content).Data(this._vars, true);
        }
    }
}
