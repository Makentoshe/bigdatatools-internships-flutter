import 'package:bigdatatools_internships/database/record/issue_record.dart';
import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:floor/floor.dart';

@dao
abstract class IssuesDao {
  @Query('SELECT * FROM IssueRecord')
  Future<List<IssueRecord>> getAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insert(IssueRecord record);

  @Query('DELETE FROM IssueRecord WHERE id = :id')
  Future<void> remove(int id);
}