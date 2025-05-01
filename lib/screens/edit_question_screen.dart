import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ap/models/question.dart';
import 'package:quiz_ap/providers/quiz_provider.dart';
import 'package:quiz_ap/widgets/fade_animation.dart';

class EditQuestionScreen extends StatefulWidget {
  final Question? question;
  final int? questionIndex;

  const EditQuestionScreen({super.key, this.question, this.questionIndex});

  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  late int _correctAnswerIndex;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
      text: widget.question?.questionText ?? '',
    );
    _optionControllers = List.generate(
      4,
          (index) => TextEditingController(
        text: widget.question?.options[index] ?? '',
      ),
    );
    _correctAnswerIndex = widget.question?.correctAnswerIndex ?? 0;
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question == null ? 'Add Question' : 'Edit Question'),
        actions: [
          if (widget.question != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                quizProvider.deleteQuestion(widget.questionIndex!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FadeAnimation(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                  TextFormField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                    hintText: 'Enter the question text',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...List.generate(4, (index) {
        return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
        children: [
        Radio<int>(
        value: index,
        groupValue: _correctAnswerIndex,
        onChanged: (value) {
        setState(() {
        _correctAnswerIndex = value!;
        });
        },
        ),
        Expanded(
        child: TextFormField(
        controller: _optionControllers[index],
        decoration: InputDecoration(
        labelText: 'Option ${index + 1}',
        hintText: 'Enter option ${index + 1}',
        ),
        validator: (value) {
        if (value == null || value.isEmpty) {
        return 'Please enter an option';
        }
        return null;
        },
        ),
        ),
        ],
        ),
        );
        }),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final question = Question(
                questionText: _questionController.text,
                options: _optionControllers.map((e) => e.text).toList(),
                correctAnswerIndex: _correctAnswerIndex,
              );

              if (widget.question == null) {
                quizProvider.addQuestion(question);
              } else {
                quizProvider.updateQuestion(
                    widget.questionIndex!, question);
              }

              Navigator.pop(context);
            }
          },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Question'),
            ),
        ],
      ),
    ),
    ),
    ),);
  }
}