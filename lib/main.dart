import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flint/connectivity/connection.dart';
import 'package:flint/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flint',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
          /* dark theme settings */
          fontFamily: 'Poppins',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff073FCF)),
            ),
          ),
          textTheme: const TextTheme(
              headline1: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
              headline2: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
              headline3: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
              headline4: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              headline5: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0xff272727)),
              // bodyText2: TextStyle(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 15,
              //     color: Color(0xff868686)),
              button: TextStyle(fontWeight: FontWeight.w700))),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff073FCF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xffffffff)),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff073FCF)),
          ),
        ),
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Color(0xff272727)),
            headline2: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35,
                color: Color(0xff868686)),
            headline3: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
            headline4: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF000000)),
            headline5: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            headline6: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            bodyText1: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff272727)),
            // bodyText2: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     fontSize: 15,
            //     color: Color(0xff868686)),
            button: TextStyle(fontWeight: FontWeight.w700)),
      ),
      // onGenerateRoute: (RouteSettings settings) {
      //   switch (settings.name) {
      //     case '/':
      //       return CupertinoPageRoute(
      //           builder: (_) => const BottomNavigation(), settings: settings);
      //     case 'voting':
      //       return CupertinoPageRoute(
      //           builder: (_) => const Voting(), settings: settings);
      //     case 'quick_action':
      //       return CupertinoPageRoute(
      //           builder: (_) => const QuickAction(), settings: settings);
      //   }
      // },
      home: const Index(),
    );
  }
}

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Map _source = {ConnectivityResult.none: false};

  final Connection _connectivity = Connection.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  void testAlert(BuildContext context) {
    var alert = AlertDialog(
      title: const Text('Aplikasi tidak terhubung dengan internet'),
      content: const Text('Tutup aplikasi atau coba lagi'),
      actions: <Widget>[
        TextButton(
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: const Text('Tutup'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Coba Lagi'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    // String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        // string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        // string = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
      default:
        {
          // string = 'Offline';
          Future.delayed(Duration.zero, () async {
            // Your Function
            testAlert(context);
          });
        }
    }

    return const RootPage();
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
