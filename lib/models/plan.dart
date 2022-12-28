import '../repositories/repository.dart';
import './task.dart';

class Plan {
  final int id;
  String name = '';
  List<Task> tasks = [];

  Plan({required this.id, this.name = ''});

  int get complteCount => tasks.where((task) => task.complete).length;

  String get completenessMessage =>
      '$complteCount di ${tasks.length} task';

  Plan.fromModel(Model model)
      : id = model.id,
        name = model.data['name'] ?? '',
        tasks = model.data['tasks']
                ?.map<Task>((task) => Task.fromModel(task))
                ?.toList() ??
            <Task>[];

  Model toModel() => Model(id: id, data: {
        'name': name,
        'tasks': tasks.map((task) => task.toModel()).toList()
      });
}
