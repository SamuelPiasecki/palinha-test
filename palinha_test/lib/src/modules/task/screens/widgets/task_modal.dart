import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palinha_test/src/modules/task/data/models/task_model.dart';
import 'package:palinha_test/src/modules/task/utils/utils.dart';

Future<Task> showTaskModal(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedOption;

  return showDialog<Task>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFEEEEEE),
        title: Text('Adicionar Tarefa'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prazo',
                    hintText: 'Selecione uma data',
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                      text: _selectedDate == null
                          ? ''
                          : '${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      _selectedDate = picked;
                      (context as Element).markNeedsBuild();
                    }
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedOption,
                  decoration: InputDecoration(labelText: 'Prioridade'),
                  items: <String>['Baixa', 'Média', 'Alta', 'Urgente']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedOption = newValue;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione uma opção';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final task = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  priority: translateOption(_selectedOption!),
                  dueDate: _selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                      : "",
                );

                Navigator.of(context).pop(task);
              }
            },
            child: Text('Adicionar Tarefa'),
          ),
        ],
      );
    },
  ).then((value) {
    return value ??
        Task(
          title: '',
          description: '',
          priority: 'medium',
          dueDate: '',
        );
  });
}
