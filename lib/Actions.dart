
import 'AppStates.dart';
import 'beans/User.dart';
import 'models/Models.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


///这个Action用于增加计数器
class IncrementCounterAction {
  // 这个Action用于增加计数器
}

///这个Action用于更新用户
class UpdateUserAction {
  final User newUser;

  UpdateUserAction(this.newUser);
}

///这个Action用于更新数据
class AddDataAction {
  final DataModel newData;

  AddDataAction(this.newData);
}

///这个Action用于搜索结果
class SearchResultAction {
  final String result;
  SearchResultAction(this.result);
}

///这个Action用于异步获取数据
ThunkAction<AppState> fetchDataAction = (Store<AppState> store) async {
  final searchResults = await Future.delayed(
    const Duration(seconds: 1),
        () => "Search Results",
  );
  store.dispatch(SearchResultAction(searchResults));
};



