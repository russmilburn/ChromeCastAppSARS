package com.tro.chromecast.service
{
	/**
	 * ...
	 * @author David Armstrong
	 */
	
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	 
	public class AccessStore 
	{
		
		public function AccessStore() 
		{
			// Completely erase the contents of the store.
			//EncryptedLocalStore.reset();	
		}
		
		public function setData(dataID:String, data:ByteArray):void
		{
			trace("AccessStore: Writing data ("+ dataID +") to Local Store.");
			EncryptedLocalStore.setItem(dataID, data);
		}
		
		public function getData(dataID:String):ByteArray
		{
			trace("AccessStore: Retreiving data ("+ dataID +") from Local Store.");
			return EncryptedLocalStore.getItem(dataID);
		}
		
		public function removeData(dataID:String):void
		{
			trace("AccessStore: Removing data ("+ dataID +") from Local Store.");
			EncryptedLocalStore.removeItem(dataID);
		}
		
		// SHORTS
		public function setShort(dataID:String, short:int):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeShort(short);
			
			setData(dataID, bytes);
		}
		
		public function getShort(dataID:String):Number
		{
			var bytes:ByteArray = EncryptedLocalStore.getItem(dataID);
			
			if (bytes != null)
			{
				return bytes.readShort();
			} else {
				trace("AccessStore: No value for " + dataID);
				return NaN;
			}
		}
		
		// NUMBERS
		public function setNumber(dataID:String, number:Number):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeFloat(number);
			
			setData(dataID, bytes);
		}
		
		public function getNumber(dataID:String):Number
		{
			var bytes:ByteArray = EncryptedLocalStore.getItem(dataID);
			
			if (bytes != null)
			{
				return bytes.readFloat();
			} else {
				trace("AccessStore: No value for " + dataID);
				return NaN;
			}
		}
		
		// STRINGS
		public function setString(dataID:String, string:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTF(string);
			
			setData(dataID, bytes);
		}
		
		public function getString(dataID:String):String
		{
			var bytes:ByteArray = EncryptedLocalStore.getItem(dataID);
			
			if (bytes != null)
			{
				return bytes.readUTF();
			} else {
				trace("AccessStore: No value for " + dataID);
				return null;
			}
		}
	}
}