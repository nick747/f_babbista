import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Babbista/plan_provider.dart';
import 'package:Babbista/views/plan_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Babbista'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildListCreator(),
            Expanded(child: _buildMasterPlans()),
          ],
        ));
  }

  Widget _buildListCreator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: 'Inserisci una lista',
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
              )
            ),
            onEditingComplete: addPlan),
      ),
    );
  }

  void addPlan() {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }

    final controller = PlanProvider.of(context);
    controller.addNewPlan(text);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildMasterPlans() {
    final plans = PlanProvider.of(context).plans;

    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.note_alt, size: 100, color: Colors.green),
          Text('Non hai ancora delle liste',
              style: TextStyle(color: Colors.grey[700], fontSize: 27),)
        ],
      );
    }

    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Dismissible(
            key: ValueKey(plan),
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              final controller = PlanProvider.of(context);
              controller.deletePlan(plan);
              setState(() {});
            },
            child: ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.completenessMessage),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PlanScreen(plan: plan)));
              },
            ),
          );
        });
  }
}
