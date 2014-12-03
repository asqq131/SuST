//
// Copyright 2013 Wintous Inc.
//
// ≥¬–Òº—
//

#ifndef SRC_GLOBAL_DB_SQL_DEFINE_H
#define SRC_GLOBAL_DB_SQL_DEFINE_H

//static const NSString *kTableGlobalCompanySchema =
//	@"CREATE TABLE IF NOT EXISTS global_company ( \
//	cid TEXT NOT NULL, \
//	banner_id TEXT, \
//	name TEXT, \
//	alias_name TEXT, \
//	PRIMARY KEY(cid)) \
//	";
//
//static const NSString *kTableGlobalUserSyncDirSchema =
//	@"CREATE TABLE IF NOT EXISTS global_user_sync_dir ( \
//	cid TEXT NOT NULL, \
//	uid TEXT NOT NULL, \
//	sync_dir_path TEXT, \
//	PRIMARY KEY(cid, uid)) \
//	";
//
//static const NSString *kTableGlobalUserSchema =
//	@"CREATE TABLE IF NOT EXISTS global_user ( \
//	uid TEXT NOT NULL, \
//	cid TEXT, \
//	username TEXT NOT NULL, \
//	password TEXT, \
//	auto_login INTEGER DEFAULT 0, \
//	auto_save_password INTEGER DEFAULT 0, \
//	last_login_time NOT NULL, \
//	PRIMARY KEY(uid),\
//	FOREIGN KEY(cid) REFERENCES global_company(cid) \
//	)";
//
//static const NSString *kTableLastSyncSnapshot =
//	@"CREATE TABLE IF NOT EXISTS last_sync_snapshort ( \
//	rid TEXT NOT NULL PRIMARY KEY, \
//	prid TEXT, \
//	fileid TEXT, \
//	item_path TEXT NOT NULL, \
//	note TEXT, \
//	is_dir INTEGER DEFAULT 0, \
//	file_revision INTEGER DEFAULT 0, \
//	file_size INTEGER DEFAULT 0, \
//	file_transferred INTEGER DEFAULT 0,\
//	file_checksum TEXT, \
//	file_conflict INTEGER DEFAULT 0, \
//	file_downloaded INTEGER DEFAULT 1, \
//	last_modified INTEGER DEFAULT 0, \
//	FOREIGN KEY(prid) REFERENCES last_sync_snapshort(rid) ON DELETE CASCADE \
//	) \
//	";
//
//static const NSString *kTableFileSyncLog =
//	@"CREATE TABLE IF NOT EXISTS file_sync_log ( \
//	id INTEGER PRIMARY KEY AUTOINCREMENT, \
//	item_path TEXT NOT NULL, \
//	is_dir INTEGER DEFAULT 0, \
//	state INTEGER DEFAULT 0, \
//	flag INTEGER DEFAULT 0, \
//	error_desc TEXT, \
//	sync_timestamp INTEGER DEFAULT 0 \
//	) \
//	";
//
//static const NSString *kTableFileTransferTask =
//	@"CREATE TABLE IF NOT EXISTS file_transfer_task ( \
//	id TEXT NOT NULL PRIMARY KEY, \
//	pid TEXT, \
//	rid TEXT, \
//	prid TEXT, \
//	cid TEXT, \
//	isdir INTEGER DEFAULT 0, \
//	level INTEGER DEFAULT 0, \
//	totaltask INTEGER DEFAULT 0, \
//	path TEXT NOT NULL, \
//	type INTEGER DEFAULT 0, \
//	state INTEGER DEFAULT 0, \
//	internal_state INTEGER DEFAULT 0, \
//	target INTEGER DEFAULT 0, \
//	is_common_download INTEGER DEFAULT 1, \
//	file_revision INTEGER DEFAULT 0, \
//	file_size INTEGER DEFAULT 0, \
//	file_transferred INTEGER DEFAULT 0, \
//	seconds INTEGER DEFAULT 0, \
//	file_checksum TEXT, \
//	error_desc TEXT, \
//	created INTEGER DEFAULT 0, \
//	modified INTEGER DEFAULT 0 \
//	) \
//	";
//
//static const NSString *kTableFileFilterFormat =  //¥¥Ω®π˝¬Àº«¬º±Ì;
//	@"CREATE TABLE IF NOT EXISTS file_filter_format ( \
//	id INTEGER PRIMARY KEY AUTOINCREMENT, \
//	filter_format TEXT NOT NULL, \
//	type INTEGER DEFAULT 0 \
//	) \
//	";

static const NSInteger kUserInfoTableColumn = 5;

static NSString* const kUserInfo =  // 用户信息表 id TEXT NOT NULL PRIMARY KEY
	@"CREATE TABLE IF NOT EXISTS userInfo ( "
	"ID INTEGER PRIMARY KEY AUTOINCREMENT, "
    "account TEXT, "
    "password TEXT, "
	"loaction_city TEXT, "
	"latitude TEXT, "
	"longitude TEXT )"
;

//static const QString kSQLLoadlatestLoginUser = 
//	"SELECT uid, cid, username, password, auto_login, auto_save_password, last_login_time \
//	FROM global_user ORDER BY last_login_time DESC LIMIT 1";
//
//static const QString kSQLCountByUidAndCid = "SELECT COUNT(*) FROM global_user WHERE uid=:uid AND cid=:cid";
//
//static const QString kSQLInsertUser = 
//	"INSERT INTO \
//	global_user(uid, cid, username, password, auto_login, auto_save_password, sync_folder, last_login_time) \
//	VALUES(:uid, :cid, :username, :password, :auto_login, :auto_save_password, :sync_folder, :last_login_time)";
//
//static const QString kSQLUpdateUser = 
//	"UPDATE global_user SET username=:username, password=:password, auto_login=:auto_login, \
//	auto_save_password=:auto_save_password, sync_folder=:sync_folder, last_login_time=:last_login_time \
//	WHERE uid=:uid AND cid=:cid";


static const NSString *kSQLSelectMetadata =
	@"SELECT rid, prid, fileid, item_path, note, is_dir, file_revision, file_size,file_checksum, file_conflict, last_modified, file_downloaded FROM last_sync_snapshort";

static const NSString *kSQLSelectFileSyncLog =
	@"SELECT id,item_path,state,flag,error_desc,sync_timestamp FROM file_sync_log";


static const NSString *kSQLSelectFileTransferTask =
	@"SELECT id,pid,rid,prid,cid,isdir,level,totaltask,path,type,state,internal_state,target,is_common_download,file_revision,file_size,file_checksum,error_desc,created,file_transferred,seconds,modified FROM file_transfer_task";


static const NSString *kSQLSelectFileFilterFormat =
	@"SELECT filter_format FROM file_filter_format";

#endif