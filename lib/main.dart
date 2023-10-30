import 'package:dewdrop/firebase_options.dart';
import 'package:dewdrop/models/bt_device.dart';
import 'package:dewdrop/models/segment.dart';
import 'package:dewdrop/models/sub_segment.dart';
import 'package:dewdrop/models/schedule.dart';
import 'package:dewdrop/screens/device_and_segment_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';
import 'utility/device_information.dart' as utility;
import 'screens/primary_segment_edit.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => BTDevices()
        ),
        ChangeNotifierProvider(
            create: (ctx) => Segments()
        ),
        ChangeNotifierProvider(
            create: (ctx) => SubSegments()
        ),
        ChangeNotifierProvider(
            create: (ctx) => Schedules()
        )
      ],
      child: MaterialApp(
        title: 'Home Automation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // dividerTheme: DividerThemeData(
          //   space: 3,
          //   thickness: 1,
          //   color: Colors.black,
          //   indent: 10,
          //   endIndent: 520,
          // )
        ),
        home: const LaunchScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          DeviceSetupScreen.routeName: (ctx) => DeviceSetupScreen(),
          // PrimarySegmentEdit.routeName: (ctx) => PrimarySegmentEdit(segment: Segment)
        }
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
    // return SplashScreen(
    //   seconds: 1,
    //   navigateAfterSeconds: const LoginScreen(),
    //   title: const Text('DewDrop',textScaleFactor: 2,),
    //   // image: new Image.network('https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
    //   image: Image.asset('resources/image.jpg'),
    //   loadingText: const Text("Loading"),
    //   photoSize: 100.0,
    //   loaderColor: Colors.blue,
    // );
  }
}
