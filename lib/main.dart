import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter calendar',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Healera Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // //bool temp = true;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
    DateTime _currentDate = DateTime(2020, 8, 3);
    DateTime _currentDate2 = DateTime(2020, 8, 4);
    String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 8, 3));
    DateTime _targetDateTime = DateTime(2020, 8, 3);

    static Widget _eventIcon = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Colors.green, width: 2.0)),
      child: new Icon(
        Icons.person,
        color: Colors.amber,
      ),
    );

    EventList<Event> _markedDateMap = new EventList<Event>(
      events: {
        new DateTime(2020, 4, 2): [
          new Event(
            date: new DateTime(2020, 4, 2),
            title: 'Doctor Ankita',
            icon: _eventIcon,
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.green,
              height: 4.0,
              width: 4.0,
            ),
          ),
          new Event(
            date: new DateTime(2020, 4, 2),
            title: 'Surgeon Mahima',
            icon: _eventIcon,
          ),
        ],
      },
    );
    EventList<Event> markedDateMap = new EventList<Event>(
      events: {
        new DateTime(2020, 4, 17): [
          new Event(
            date: new DateTime(2020, 4, 17),
            title: 'Doctor Ankita',
            icon: _eventIcon,
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.redAccent,
              height: 5.0,
              width: 5.0,
            ),
          ),
          new Event(
            date: new DateTime(2020, 8, 17),
            title: 'Surgeon Mahima',
            icon: _eventIcon,
          ),
        ],
      },
    );
    CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
    @override
    void initState() {
      _markedDateMap.addAll(new DateTime(2020, 4, 13), [
        new Event(
          date: new DateTime(2020, 4, 13),
          title: 'Doctor Ankita',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 4, 12),
          title: 'Surgeon Vinamra',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 4, 12),
          title: 'ER Jonathan Emergency Meeting!',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 8, 13),
          title: 'Pediatrics: All Admin Meeting',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 4, 7),
          title: 'Doctor Richa',
          icon: _eventIcon,
        ),
      ]);
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      _calendarCarouselNoHeader = CalendarCarousel<Event>(
        todayBorderColor: Colors.green,
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate2 = date);
          events.forEach((event) => print(event.title));
        },
        daysHaveCircularBorder: true,
        showOnlyCurrentMonthDate: true,
        weekendTextStyle: TextStyle(
          color: Colors.black,
        ),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
//      firstDayOfWeek: 4,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate2,
        targetDateTime: _targetDateTime,
        customGridViewPhysics: NeverScrollableScrollPhysics(),

        minSelectedDate: _currentDate.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),

        inactiveDaysTextStyle: TextStyle(
          color: Colors.pink,
          fontSize: 16,
        ),
        onCalendarChanged: (DateTime date) {
          this.setState(() {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          });
        },
        onDayLongPressed: (DateTime date) {
          print('long pressed date $date');
        },
      );
      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text(widget.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //custom icon
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarousel,
                ),
                // This trailing comma makes auto-formatting nicer for build methods.
                //custom icon without header
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            _currentMonth,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          )),
                      TextButton(
                        child: Text('PREV'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      TextButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),
                //
              ],
            ),
          ));
    }
  }

//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
