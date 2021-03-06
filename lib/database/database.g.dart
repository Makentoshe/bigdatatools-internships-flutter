// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  IssuesDao? _issuesDaoInstance;

  TagsDao? _tagsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IssueRecord` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `order` INTEGER NOT NULL, `summary` TEXT NOT NULL, `description` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TagRecord` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `issueId` INTEGER NOT NULL, `title` TEXT NOT NULL, `color` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  IssuesDao get issuesDao {
    return _issuesDaoInstance ??= _$IssuesDao(database, changeListener);
  }

  @override
  TagsDao get tagsDao {
    return _tagsDaoInstance ??= _$TagsDao(database, changeListener);
  }
}

class _$IssuesDao extends IssuesDao {
  _$IssuesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _issueRecordInsertionAdapter = InsertionAdapter(
            database,
            'IssueRecord',
            (IssueRecord item) => <String, Object?>{
                  'id': item.id,
                  'order': item.order,
                  'summary': item.summary,
                  'description': item.description
                }),
        _issueRecordUpdateAdapter = UpdateAdapter(
            database,
            'IssueRecord',
            ['id'],
            (IssueRecord item) => <String, Object?>{
                  'id': item.id,
                  'order': item.order,
                  'summary': item.summary,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<IssueRecord> _issueRecordInsertionAdapter;

  final UpdateAdapter<IssueRecord> _issueRecordUpdateAdapter;

  @override
  Future<List<IssueRecord>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM IssueRecord',
        mapper: (Map<String, Object?> row) => IssueRecord(
            row['summary'] as String,
            row['description'] as String,
            row['id'] as int?,
            row['order'] as int));
  }

  @override
  Future<void> remove(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM IssueRecord WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insert(IssueRecord record) {
    return _issueRecordInsertionAdapter.insertAndReturnId(
        record, OnConflictStrategy.replace);
  }

  @override
  Future<void> update(IssueRecord record) async {
    await _issueRecordUpdateAdapter.update(record, OnConflictStrategy.abort);
  }
}

class _$TagsDao extends TagsDao {
  _$TagsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _tagRecordInsertionAdapter = InsertionAdapter(
            database,
            'TagRecord',
            (TagRecord item) => <String, Object?>{
                  'id': item.id,
                  'issueId': item.issueId,
                  'title': item.title,
                  'color': item.color
                }),
        _tagRecordUpdateAdapter = UpdateAdapter(
            database,
            'TagRecord',
            ['id'],
            (TagRecord item) => <String, Object?>{
                  'id': item.id,
                  'issueId': item.issueId,
                  'title': item.title,
                  'color': item.color
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TagRecord> _tagRecordInsertionAdapter;

  final UpdateAdapter<TagRecord> _tagRecordUpdateAdapter;

  @override
  Future<List<TagRecord>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM TagRecord',
        mapper: (Map<String, Object?> row) => TagRecord(
            row['id'] as int?,
            row['issueId'] as int,
            row['title'] as String,
            row['color'] as int?));
  }

  @override
  Future<List<TagRecord>> getAllByIssueId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM TagRecord WHERE issueId = ?1',
        mapper: (Map<String, Object?> row) => TagRecord(
            row['id'] as int?,
            row['issueId'] as int,
            row['title'] as String,
            row['color'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> removeById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM TagRecord WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> removeByIssueId(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM TagRecord WHERE issueId = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insert(TagRecord record) {
    return _tagRecordInsertionAdapter.insertAndReturnId(
        record, OnConflictStrategy.replace);
  }

  @override
  Future<void> update(TagRecord record) async {
    await _tagRecordUpdateAdapter.update(record, OnConflictStrategy.abort);
  }
}
