import 'package:flutter/cupertino.dart';
import './controllers/plan_controller.dart';

class PlanProvider extends InheritedWidget {
  final _controller = PlanController();
  PlanProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static PlanController of(BuildContext context) {
    PlanProvider? provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;
  }
}
