import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praaccc/firebase_options.dart';
import 'package:praaccc/home.dart';
import 'package:praaccc/login.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: lightColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: Colors.blue, brightness: Brightness.light),
          useMaterial3: true,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ??
              ColorScheme.fromSeed(
                  seedColor: Colors.blue, brightness: Brightness.dark),
          useMaterial3: true,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
        ),
        routes: {
          '/start': (context) => FirstPage(),
          '/home': (context) => HomePage(),
        },
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/start' : '/home',
        // '/start',
      );
    });
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool dragged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).brightness == Brightness.light
      //     ? Colors.white
      //     : Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15,
                  bottom: 160 + MediaQuery.viewPaddingOf(context).bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'The',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 50.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                        TypewriterAnimatedText('Praaccc',
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                      repeatForever: true,
                      isRepeatingAnimation: true,
                    ),
                  ),
                  Text(
                    'App',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://sites.google.com/view/firebolt9907/privacy-policy-praaccc"));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "By clicking 'Get Started', you accept our Privacy Policy (click to view)",
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 80 + MediaQuery.viewPaddingOf(context).bottom,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dy < 0 && !dragged) {
                        dragged = true;
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EmailPage(),
                            ));
                      }
                    },
                    child: CupertinoButton(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.viewPaddingOf(context).bottom),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EmailPage(),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
