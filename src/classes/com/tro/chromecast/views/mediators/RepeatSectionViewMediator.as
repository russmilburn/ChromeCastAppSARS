/**
 * Created by russellmilburn on 02/09/15.
 */
package com.tro.chromecast.views.mediators
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.ApplicationModel;
	import com.tro.chromecast.models.ApplicationModelEvent;
	import com.tro.chromecast.models.states.section.Section;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.views.RepeatSectionView;
	import com.tro.chromecast.views.ViewEvent;
	import com.tro.chromecast.views.components.buttons.NavigationBtnEvent;
	import com.tro.chromecast.views.components.SwipeControlEvent;

	import org.gestouch.gestures.TapGesture;

	public class RepeatSectionViewMediator extends BaseMediator
	{

		[Inject]
		public var view : RepeatSectionView;

		private var currentSectionId: String;


		public function RepeatSectionViewMediator()
		{
			super();
		}

		override public function initialize():void
		{
			super.initialize();

			view.logger = super.logger;
			view.assetManager = assetStore.assetManager;

			addContextListener(ApplicationModelEvent.ON_SECTION_SELECTED, onSectionSelected);

			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			view.addEventListener(ViewEvent.ON_VIEW_IN_COMPLETE, onViewInComplete);

			view.addEventListener(SwipeControlEvent.SWIPE_LEFT, onSwipeLeft);
			view.addEventListener(SwipeControlEvent.SWIPE_RIGHT, onSwipeRight);
		}

		private function onViewInComplete(event:ViewEvent):void
		{
			dispatch(new AppEvent(AppEvent.OPEN_NAV_MENU));
		}

		private function onViewInitComplete(event:ViewEvent):void
		{
			view.repeatBtn.addEventListener(NavigationBtnEvent.ON_TAP, onRepeatTapHandler);
			view.continueBtn.addEventListener(NavigationBtnEvent.ON_TAP, onContinueTapHandler);
		}

		private function onSectionSelected(event :ApplicationModelEvent):void
		{
			currentSectionId = event.selectedSection;

			if (currentSectionId == SectionList.AR_SECTION)
			{
				//view.tvDisplay.bodyCopyText = "Setting up Chromecast is simple. \nLearn how to Plug In \nChromecast to your TV";
				view.continueBtn.visible = false;
				view.repeatBtn.visible = false;

				view.congratsTextField.visible = true;
				view.bodyText.visible = true;
				view.tvDisplay.bodyCopyField.visible = false;


			}
			else if (currentSectionId == SectionList.ENJOY_SECTION)
			{
				view.tvDisplay.bodyCopyText = "Discover more apps and \nDo more with Chromecast";
				view.congratsTextField.visible = false;
				view.bodyText.visible = false;

				view.continueBtn.visible = true;
				view.repeatBtn.visible = true;
				view.tvDisplay.bodyCopyField.visible = true;

			}
			else if (currentSectionId == SectionList.PLUG_IN_SECTION)
			{
				view.tvDisplay.bodyCopyText = "Now let’s Connect your \nChromecast to Wi-Fi";
				view.congratsTextField.visible = false;
				view.bodyText.visible = false;

				view.continueBtn.visible = true;
				view.repeatBtn.visible = true;
				view.tvDisplay.bodyCopyField.visible = true;
			}
			else if (currentSectionId == SectionList.CONNECT_SECTION)
			{
				view.tvDisplay.bodyCopyText = "Let’s get Casting!";
				view.congratsTextField.visible = false;
				view.bodyText.visible = false;

				view.continueBtn.visible = true;
				view.repeatBtn.visible = true;
				view.tvDisplay.bodyCopyField.visible = true;
			}
		}

		private function onContinueTapHandler(event:NavigationBtnEvent):void
		{
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			switch (currentSectionId)
			{
				case SectionList.PLUG_IN_SECTION:
					evt.sectionName = SectionList.CONNECT_SECTION;
					break;
				case SectionList.CONNECT_SECTION:
					evt.sectionName = SectionList.ENJOY_SECTION;
					break;
				case SectionList.ENJOY_SECTION:
					evt.sectionName = SectionList.DO_MORE_SECTION;
					break;
				default :
					return;
					break;
			}
			dispatch(evt);

		}

		private function onRepeatTapHandler(event:NavigationBtnEvent):void
		{
			event.stopPropagation();
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = currentSectionId;
			dispatch(evt);
		}



	}
}
