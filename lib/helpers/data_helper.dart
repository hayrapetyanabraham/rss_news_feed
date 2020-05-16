import 'package:get_it/get_it.dart';
import 'package:newsfeed/constants/db_constants.dart';
import 'package:newsfeed/models/news_feed/news_feed.dart';
import 'package:newsfeed/store/database/database_state.dart';
import 'package:sembast/sembast.dart';

class DataHelper {
  final _newsFeedStore = intMapStoreFactory.store(DBConstants.newsFeed);
  final _databaseState = GetIt.I<DatabaseState>();

  Future<void> insertAll(List<NewsFeed> newsFeed) async {
    await _newsFeedStore.delete(_databaseState.database);
    return _newsFeedStore.addAll(_databaseState.database,
        newsFeed.map((newsFeed) => newsFeed.toJson()).toList());
  }

  Future<int> count() async {
    return _newsFeedStore.count(_databaseState.database);
  }

  Future<List<NewsFeed>> getAllNewsFeed() async {
    final snapshots = await _newsFeedStore.find(
      _databaseState.database,
    );
    return snapshots.map((snapshot) {
      final newsFeed = NewsFeed.fromJson(snapshot.value);
      return newsFeed;
    }).toList();
  }

  Future<int> update({NewsFeed newsFeed}) async {
    final finder = Finder(filter: Filter.byKey(newsFeed.date));
    return _newsFeedStore.update(
      _databaseState.database,
      newsFeed.toJson(),
      finder: finder,
    );
  }

  Future<void> add({NewsFeed newsFeed}) async {
    final count = await _newsFeedStore.count(_databaseState.database,
        filter: Filter.equals("date", newsFeed.date));
    if (count > 0) return;
    return _newsFeedStore.add(_databaseState.database, newsFeed.toJson());
  }

  Future<void> delete({NewsFeed newsFeed}) async {
    final finder = Finder(filter: Filter.equals("date", newsFeed.date));
    await _newsFeedStore.delete(_databaseState.database, finder: finder);
  }

  Future deleteAll() async {
    await _newsFeedStore.drop(
      _databaseState.database,
    );
  }
}
