import 'package:flutter/material.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/screen/root.dart';
import 'package:nike_store/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<ThemeMode> theme = ValueNotifier(ThemeMode.light);
void main() async {
  FavoriteManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadTokens();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void loadTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString("theme") == "dark") {
        theme.value = ThemeMode.dark;
      } else {
        theme.value = ThemeMode.light;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike Store',
      theme: theme.value == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme()
          : MyAppThemeConfig.light().getTheme(),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: RootScreen(
            onTap: methodSwitch,
          )),
    );
  }

  void methodSwitch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (theme.value == ThemeMode.dark) {
        sharedPreferences.setString("theme", "light");
        theme.value = ThemeMode.light;
      } else {
        sharedPreferences.setString("theme", "dark");
        theme.value = ThemeMode.dark;
      }
    });
  }
}
