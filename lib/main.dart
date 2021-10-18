import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Inherited Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          MyInheritedWidget(AppRootWidget(), this),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          Text('(Root Widget)', style: Theme.of(context).textTheme.bodyText1,),
          Text('${rootWidgetState?.counterValue}', style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Counter(),
              Counter(),
            ],
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        children: [
          Text('(Child Widget)'),
          Text('${rootWidgetState?.counterValue}', style: Theme.of(context).textTheme.bodyText1),
          ButtonBar(
            children: [
              IconButton(icon: Icon(Icons.remove),
              color: Colors.red,
                onPressed: () => rootWidgetState?._decrementCounter(),
              ),
              IconButton(icon: Icon(Icons.add),
                color: Colors.green,
                onPressed: () => rootWidgetState?._incrementCounter(),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class MyInheritedWidget extends InheritedWidget {
  final _MyHomePageState myState;

  MyInheritedWidget(Widget child, this.myState) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}