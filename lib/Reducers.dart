import 'package:redux/redux.dart';

import 'Actions.dart';
import 'AppStates.dart';

final appReducers = combineReducers<AppState>([
  TypedReducer<AppState, IncrementCounterAction>(_onIncrementCounter),
  TypedReducer<AppState, UpdateUserAction>(_updateUser),
  TypedReducer<AppState, AddDataAction>(_addData)
]);


AppState _onIncrementCounter(AppState state, IncrementCounterAction action) {
  return IncrementCounterState(
    user: state.user,
    data: state.data,
    counter: state is IncrementCounterState ? state.counter + 1 : 0,
  );
}

AppState _updateUser(AppState state, UpdateUserAction action) {
  return UpdateUserState(
      user: action.newUser,
      data: state.data);
}

AppState _addData(AppState state, AddDataAction action) {
  state.data.add(action.newData);
  return AddDataState(
      user: state.user,
      data: state.data);
}

