/**
 * Created by russellmilburn on 24/07/15.
 */
package com.tro.chromecast.service
{
	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.models.AbstractModel;

	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	public class DatabaseService extends AbstractModel
	{
		private const DB_NAME:String = "TrackingDB.db";
		
		public static const TRACKING_TBL:String = 'Tracking_tbl';
		public static const SESSION_TBL:String = 'Session_tbl';
		
		public static const TRACKING_ID_FLD:String = "ID";
		public static const SECTION_FLD:String = "SectionName";
		public static const OS_FLD : String = "OperatingSystem";
		public static const VERSION_NUMBER_FLD:String = "VersionNumber";
		public static const FLOX_PLAYER_ID_FLD:String = "FloxPlayerID";
		
		public static const SESSION_ID_FLD:String = "ID";
		public static const SESSION_DATE_FLD:String = "SessionDate";
		public static const SESSION_START_TIME_FLD:String = "SessionEndTime";
		public static const SESSION_END_TIME_FLD:String = "SessionStartTime";
		public static const SESSION_DURATION_FLD :String = "SessionDuration";
		
		public static const TRACKING_CODE:String = "TrackingCode";
		public static const TRACKING_PARAMETER:String = "TrackingParameter";
		public static const TRACKING_VALUE:String = "TrackingValue";
		
		private var dbPath:File;
		private var folder:File;
		
		private var sqlCon:SQLConnection;
		
		private var sqlCreate:SQLStatement;
		
		private var sqlInsert:SQLStatement;
		private var sqlUpdate:SQLStatement;
		private var sqlRead:SQLStatement;
		private var sqlDelete:SQLStatement;
		
		
		private var _isConnected : Boolean = false;
		
		public function DatabaseService()
		{
		
		}
		
		public function init():void
		{
			//logger.info("DatabaseService.INIT DATABASE SERVICE");
		}
		
		public function connect():void
		{
			sqlCon = new SQLConnection();
			sqlCon.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlCon.addEventListener(SQLEvent.CLOSE, onDisconnectDatabase);
			
			folder = File.applicationDirectory;
			
			dbPath = folder.resolvePath(DB_NAME);
			
			if (dbPath.exists)
			{
				//logger.info("DatabaseService.Database Path resolved");
				
				sqlCon.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
				sqlCon.openAsync(dbPath);
			}
			else
			{
				//logger.info("DatabaseService.Datbase Path not resolved");
				createDB();
			}
		}
		
		public function disconnect():void
		{
			sqlCon.close();
		}
		
		private function onDatabaseOpen(event:SQLEvent):void
		{
			logger.info("[START UP 1A] datbase connected" );
			isConnected = true;
			
			dispatch(new AppEvent(AppEvent.INIT_DATABASE_COMPLETE));
			
		}
		
		private function onDisconnectDatabase(event:SQLEvent):void
		{
			isConnected = false;
		}
		
		public function createDB():void
		{
			sqlCon.addEventListener(SQLEvent.OPEN, onCreateDatabaseComplete);
			sqlCon.openAsync(dbPath);
		}
		
		public function get isConnected():Boolean
		{
			return _isConnected;
		}
		
		public function set isConnected(value:Boolean):void
		{
			_isConnected = value;
			
			var evt : DatabaseServiceEvent;
			
			//logger.info("isConnected :" + _isConnected);
			
			if (_isConnected)
			{
				evt = new DatabaseServiceEvent(DatabaseServiceEvent.ON_CONNECT);
				
				evt.isConnected = _isConnected;
				
				dispatch(evt);
			}
			else
			{
				evt = new DatabaseServiceEvent(DatabaseServiceEvent.ON_DISCONNECT);
				
				evt.isConnected = _isConnected;
				
				dispatch(evt);
			}
		}
		
		private function onCreateDatabaseComplete(event:SQLEvent):void
		{
			sqlCreate = new SQLStatement();
			
			var query : String = "CREATE TABLE " + SESSION_TBL + " ("
					+ TRACKING_CODE + " TEXT, "
					+ TRACKING_PARAMETER + " TEXT, "
					+ TRACKING_VALUE + " VARCHAR)";
			
			sqlCreate.addEventListener(SQLEvent.RESULT, onSessionTableCreated);
			sqlCreate.sqlConnection = sqlCon;
			sqlCreate.text = query;
			sqlCreate.execute();
		}
		
		private function onSessionTableCreated(event:SQLEvent):void
		{
			sqlCreate.removeEventListener(SQLEvent.RESULT, onSessionTableCreated);
			sqlCreate.removeEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlCreate = null;
			
			isConnected = true;
			logger.info("[START UP 1B] DATA BASE CREATED COMPLETE and datbase connected" );
			dispatch(new AppEvent(AppEvent.INIT_DATABASE_COMPLETE));
		}
		
		public function insertData(table:String, fields:Array, values:Array):void
		{
			var numOfFields :int = fields.length;
			
			//Start of Query
			var query:String = "INSERT INTO "+table+" (";
			
			//Loop through the number of fields in field array
			for (var i:int = 0; i < numOfFields; i ++)
			{
				query += fields[i];
				
				if (numOfFields > 1 && i < (numOfFields - 1))
				{
					query += ", ";
				}
				else if (i == numOfFields - 1)
				{
					query += ") VALUES (";
				}
			}
			
			for (var j:int = 0; j < numOfFields; j ++)
			{
				query += ":" +fields[j].toLowerCase();
				
				if (numOfFields > 1 && j < (numOfFields - 1) )
				{
					query += ", ";
				}
				else if (j == (numOfFields-1) )
				{
					query += ");";
				}
			
			}
			
			//logger.info(query);
			
			sqlInsert = new SQLStatement();
			sqlInsert.sqlConnection = this.sqlCon;
			sqlInsert.addEventListener(SQLEvent.RESULT, onInsertQueryComplete);
			sqlInsert.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlInsert.text = query;
			
			for (var k:int = 0; k < numOfFields; k ++)
			{
				//logger.info(":" + fields[k].toLowerCase());
				//logger.info(values[k]);
				sqlInsert.parameters[":" + fields[k].toLowerCase()] = values[k];
			}
			sqlInsert.execute();
		}
		
		private function onInsertQueryComplete(event:SQLEvent):void
		{
			sqlInsert.removeEventListener(SQLEvent.RESULT, onInsertQueryComplete);
			sqlInsert.removeEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlInsert = null;
		}
		
		public function readData(table:String, fields:Array):void
		{
			sqlRead = new SQLStatement();
			
			var numOfFields :int = fields.length;
			
			var query:String = "SELECT ";
			
			for (var i:int = 0; i < numOfFields; i ++)
			{
				query += fields[i];
			
				if (numOfFields > 1 && i < (numOfFields - 1))
				{
					query += ", ";
				}
				else if (i == numOfFields - 1)
				{
					query += " FROM " + table;
				}
			}
			
			//logger.info(query);
			
			sqlRead.sqlConnection = sqlCon;
			sqlRead.text = query;
			
			sqlRead.addEventListener(SQLEvent.RESULT, onSelectQueryResult);
			sqlRead.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			
			sqlRead.execute();
		}
		
		private function onSelectQueryResult(event:SQLEvent):void
		{
			//logger.info("onSelectQueryResult");
			sqlRead.removeEventListener(SQLEvent.RESULT, onSelectQueryResult);
			sqlRead.removeEventListener(SQLErrorEvent.ERROR, onSQLError);
			
			var sqlResult : SQLResult = sqlRead.getResult();
			
			var evt : DatabaseServiceEvent = new DatabaseServiceEvent(DatabaseServiceEvent.ON_DATABASE_RESULT);
			evt.data = sqlResult;
			dispatch(evt);
			
			sqlRead = null;
		}
		
		public function updateData(table : String, fields:Array, values:Array, recordID:int) : void
		{
			//TODO: implement the updateData method.
		}
		
		public function deleteData(table : String):void
		{
			var query:String = "DELETE FROM "+table;
			
			sqlDelete = new SQLStatement();
			sqlDelete.sqlConnection = sqlCon;
			sqlDelete.text = query;
			sqlDelete.addEventListener(SQLEvent.RESULT, onDeleteDataComplete);
			sqlDelete.addEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlDelete.execute();
		}
		
		private function onDeleteDataComplete(event:SQLEvent):void
		{
			sqlDelete.removeEventListener(SQLEvent.RESULT, onDeleteDataComplete);
			sqlDelete.removeEventListener(SQLErrorEvent.ERROR, onSQLError);
			sqlDelete = null;
		}
		
		private function onSQLError(event:SQLErrorEvent):void
		{
			logger.warn(event.error);
		}
	}
}
