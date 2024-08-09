import 'package:flutter_modular/flutter_modular.dart';
import 'package:palinha_test/src/modules/home/screens/home_screen.dart';
import 'package:palinha_test/src/modules/main/screens/main_scaffold.dart';
import 'package:palinha_test/src/modules/main/screens/splash_screen.dart';
import 'package:palinha_test/src/modules/task/screens/task_screen.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => SplashScreen());
    r.child('/main', child: (context) => MainScaffold(), children: [
      ChildRoute('/home', child: (context) => HomeScreen()),
      ChildRoute('/tasks', child: (context) => TaskScreen()),
    ]);
  }
}
