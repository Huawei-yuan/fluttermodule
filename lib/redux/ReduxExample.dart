// One simple action: Increment

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'SecondReduxPage.dart';

enum Actions {
  increament, //加
  decreament //减
}

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int countReducer(int state, dynamic action) {
  print("countReducer state = $state, action = $action");
  switch (action) {
    case Actions.increament:
      return state + 1;
    case Actions.decreament:
      return state - 1;
  }
  return state;
}

class FlutterReduxApp extends StatelessWidget {
  // Create your store as a final variable in the main function or inside a
  // State object. This works better with Hot Reload than creating it directly
  // in the `build` function.
  final Store<int> store;
  final String title;

  const FlutterReduxApp({super.key, required this.store, required this.title});

  @override
  Widget build(BuildContext context) {
    print("FlutterReduxApp build");
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return StoreProvider<int>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: MaterialApp(
        title: title,
        routes: {
          '/secondReduxPage': (context) => SecondReduxPage(),
        },
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Connect the Store to a Text Widget that renders the current
                // count.
                //
                // We'll wrap the Text Widget in a `StoreConnector` Widget. The
                // `StoreConnector` will find the `Store` from the nearest
                // `StoreProvider` ancestor, convert it into a String of the
                // latest count, and pass that String  to the `builder` function
                // as the `count`.
                //
                // Every time the button is tapped, an action is dispatched and
                // run through the reducer. After the reducer updates the state,
                // the Widget will be automatically rebuilt with the latest
                // count. No need to manually manage subscriptions or Streams!
                StoreConnector<int, String>(
                    builder: (builder, count) => Text(
                          'The button has been pushed this many times: $count',
                          style: const TextStyle(fontSize: 20),
                        ),
                    converter: (store) => store.state.toString()),
                Builder(builder: (builderContext) {
                  return ElevatedButton(
                    onPressed: () => Navigator.of(builderContext)
                        .pushNamed('/secondReduxPage'),
                    child: const Text("跳转到SecondReduxPage"),
                  );
                })
              ],
            ),
          ),
          // Connect the Store to a FloatingActionButton. In this case, we'll
          // use the Store to build a callback that will dispatch an Increment
          // Action.
          //
          // Then, we'll pass this callback to the button's `onPressed` handler.
          floatingActionButton: StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () {
                print(
                    "floatingActionButton converter store.state = ${store.state}");
                if (store.state >= 10) {
                  store.dispatch(Actions.decreament);
                } else {
                  store.dispatch(Actions.increament);
                }
              };
            },
            builder: (context, callback) => FloatingActionButton(
              onPressed: callback,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
