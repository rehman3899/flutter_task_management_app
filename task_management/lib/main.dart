import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management/data/hive_data_store.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/home/home_screen.dart';

Future<void> main() async {
  // Initialize Hive and Flutter bindings for Hive.
  //await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  // Register the TaskAdapter to handle serialization of Task objects.
  Hive.registerAdapter<Task>(TaskAdapter());

  // Open the Hive box for storing Task objects.
  await Hive.openBox<Task>(HiveDataStore.boxName);

  // Start the Flutter application by running MyApp wrapped in BaseWidget.
  runApp(BaseWidget(child: const MyApp()));
}

// BaseWidget is an InheritedWidget that provides access to HiveDataStore throughout the widget tree.
class BaseWidget extends InheritedWidget {
  // Constructor for BaseWidget, initializing with the child widget.
  BaseWidget({super.key, required this.child}) : super(child: child);

  // Instance of HiveDataStore that can be accessed by descendant widgets.
  final HiveDataStore dataStore = HiveDataStore();

  @override
  // ignore: overridden_fields
  final Widget child;

  // Provides access to the nearest instance of BaseWidget in the widget tree.
  static BaseWidget of(BuildContext context) {
    final base = context.getInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find widget of type BaseWidget');
    }
  }

  @override
  // Returns false to indicate that the widget does not need to rebuild when the inherited widget updates.
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

// MyApp is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disables the debug banner.
      theme: ThemeData(
        // Defines the text theme for the application.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const HomeScreen(), // Sets the HomeScreen as the initial route.
    );
  }
}
