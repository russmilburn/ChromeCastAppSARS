/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.greensock.TweenMax;
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AssetStorage;
	import com.tro.chromecast.models.PinCodeModelEvent;
	import com.tro.chromecast.views.LoginView;
	import com.tro.chromecast.views.LoginViewEvent;
	import com.tro.chromecast.views.ViewEvent;

	import org.gestouch.events.GestureEvent;

	public class LoginViewMediator extends BaseMediator
	{
		[Inject]
		public var view:LoginView;


		private var code:String = "";

		public function LoginViewMediator()
		{
			super();
		}

		override public function initialize():void
		{
			super.initialize();

			//logger.info("initialize" + view);

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			addContextListener(PinCodeModelEvent.ON_PIN_SUCCESS, onPinSuccess);
			addContextListener(PinCodeModelEvent.ON_PIN_FAIL, onPinFail);

			view.addEventListener(LoginViewEvent.KEY_PRESSED, onKeyPadNumberHandler);
			view.addEventListener(LoginViewEvent.BACK_BUTTON_PRESSED, onBackspaceBtnHandler);

			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInitComplete);
		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			view.jbHiFiLogoSprite.tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onLogoTap);
		}

		private function onLogoTap(event:GestureEvent):void
		{
			checkPin(1234);
		}


		private function onBackspaceBtnHandler(event:LoginViewEvent):void
		{
			//trace(this + " BackButtonPressed");
			if (code.length > 0)
			{
				shavePinCode();
				view.backspaceButtonPressed();
			}
		}

		private function onKeyPadNumberHandler(event:LoginViewEvent):void
		{
			//logger.info("onKeyPadNumberHandler" + event.value);

			event.stopPropagation();
			//logger.info("code length" + code.length);

			if (code.length < 3)
			{
				code += event.value;
				view.updatePinCodeBox(event.value, code.length);
			}
			else
			{
				code += event.value;

				view.updatePinCodeBox(event.value, code.length);
				checkPin(Number(code));
			}
		}

		private function shavePinCode():void
		{
			var temp:String = code.substr(0, code.length - 1);
			code = temp;
		}

		private function checkPin(code:Number):void
		{
			var evt:AppEvent = new AppEvent(AppEvent.CHECK_PIN_CODE);
			evt.picCode = code;
			dispatch(evt);
		}

		private function onPinSuccess(event:PinCodeModelEvent):void
		{
			//logger.info("onPinSuccess");
			code = "";
			view.clearPinCode();
			dispatch(new AppEvent(AppEvent.SWIPE_LEFT));

		}

		private function onPinFail(event:PinCodeModelEvent):void
		{
			//logger.info("onPinFail");
			view.displayFailFeedback();
			code = "";
		}
	}
}
