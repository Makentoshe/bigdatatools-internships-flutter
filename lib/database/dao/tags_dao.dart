import 'package:bigdatatools_internships/database/record/tag_record.dart';
import 'package:floor/floor.dart';

@dao
abstract class TagsDao {

  @Query('SELECT * FROM TagRecord')
  Future<List<TagRecord>> getAll();

  @Query('SELECT * FROM TagRecord WHERE issueId = :id')
  Future<List<TagRecord>> getAllByIssueId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insert(TagRecord record);

  @Query('DELETE FROM TagRecord WHERE id = :id')
  Future<void> removeById(int id);

  @Query('DELETE FROM TagRecord WHERE issueId = :id')
  Future<void> removeByIssueId(int id);

  @Update()
  Future<void> update(TagRecord record);
}
