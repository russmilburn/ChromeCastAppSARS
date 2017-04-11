package com.tro.chromecast.service 
{
	/**
	 * ...
	 * @author Andrew Day
	 */

	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AbstractModel;
	import com.tro.chromecast.models.vos.CustomPlayerVo;
	import com.tro.chromecast.models.vos.TrackingVo;

	import com.tro.chromecast.service.AccessStore;

	public class FloxService extends AbstractModel
	{
		private var accessStore:AccessStore;
		
		public function FloxService() 
		{
			
		}
		
		public function init():void 
		{
			accessStore = new AccessStore();
			
			Flox.playerClass = CustomPlayerVo;
			Flox.init("XDS53fzoAOV0BIWa", "1PvXtKZy0M6bDv7x", "0.9");
			
			Player.loginWithKey(checkID(), onLogin, onLoginError);
		}
		
		public function logEvent(vo:TrackingVo):void
		{
			Flox.logEvent(vo.code, vo);
		}
		
		private function onLogin():void
		{
			logger.info("[START UP 3] - onLogin");
			
			var currentPlayer:CustomPlayerVo = Player.current as CustomPlayerVo;
			currentPlayer.app_launches = checkAppInits();
			currentPlayer.save(onCompleteSaved, onErrorSaved);
			
			dispatch(new AppEvent(AppEvent.INIT_FLOX_COMPLETE));
		}
		
		private function checkID():String
		{
			var currentPlayerID:String;
			
			if (accessStore.getString("currentPlayerID") == null)
			{
				currentPlayerID = generateRandomString(16);
				accessStore.setString("currentPlayerID", currentPlayerID);
			} else {
				currentPlayerID = accessStore.getString("currentPlayerID")
			}
			
			return currentPlayerID;
		}
		
		private function checkAppInits():Number
		{
			var appInits:Number;
			
			if (isNaN(accessStore.getNumber("appInits")))
			{
				appInits = 1;
				accessStore.setNumber("appInits", appInits);
			} else {
				appInits = accessStore.getNumber("appInits") + 1;
				accessStore.setNumber("appInits", appInits);
			}
			
			return appInits;
		}
		
		private function generateRandomString(strlen:Number):String
		{
			var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			var num_chars:Number = chars.length - 1;
			var randomChar:String = "";
			
			for (var i:Number = 0; i < strlen; i++)
			{
				randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
			}
			
			return randomChar;
		}
		
		private function onLoginError():void
		{
			//logger.info(" - onLoginError");
			
			dispatch(new AppEvent(AppEvent.INIT_FLOX_COMPLETE));
		}
		
		private function onCompleteSaved():void
		{
			//logger.info(" - onCompleteSaved");
		}
		
		private function onErrorSaved():void
		{
			//logger.info(" - onErrorSaved");
		}
	}
}