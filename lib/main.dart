import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honeymoon_flutter/details_view.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';
import 'package:honeymoon_flutter/swipable_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => MaterialPage(
              child: SwipableView(title: 'Honeymoon Flutter'),
            ),
            routes: [
              GoRoute(
                path: 'detailPage',
                pageBuilder: (context, state) {
                  // Extract the movieId from the route parameters
                  final selectedArray = state.extra! as List<HoneymoonLocation>;
                  return MaterialPage(
                    child: DetailsView(
                      selectedArray: selectedArray,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
      // home: const MyHomePage(title: 'Honeymoon Flutter'),
    );
  }
}
