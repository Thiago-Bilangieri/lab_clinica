import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/src/loader/lab_clinica_loader.dart';
import 'package:lab_clinica_core/src/theme/lab_clinica_theme.dart';

class LabClinicasCoreConfig extends StatelessWidget {
  const LabClinicasCoreConfig(
      {super.key,
      this.bindings,
      this.pages,
      this.pagesBuilders,
      this.modules,
      required this.title,
      this.didStart});

  final ApplicationBindings? bindings;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;
  final VoidCallback? didStart;

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: kDebugMode,
      bindings: bindings,
      pages: [...pages ?? [], ...pagesBuilders ?? []],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          loader: LabClinicaLoader(),
          builder: (navigatorObserver) {
            if (didStart != null) {
              didStart!();
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LabClinicaTheme.lightTheme,
              darkTheme: LabClinicaTheme.darkTheme,
              routes: routes,
              title: title,
              navigatorObservers: [
                flutterGetItNavObserver,
                navigatorObserver,
              ],
            ); 
          },
        );
      },
    );
  }
}
