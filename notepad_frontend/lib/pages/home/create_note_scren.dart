// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/note/note_api.dart';
import 'package:notepad_frontend/models/user_cubit.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/home/home.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late User user;
  @override
  void initState() {
    user = context.read<UserCubit>().state;
    // TODO: implement initState
    super.initState();
  }
// flutter run
  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    noteController.text.isNotEmpty) {
                  var a = await createNote(
                    user,
                    titleController.text,
                    noteController.text,
                  );
                  if (a) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false);
                  }
                }
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(children: [
        const Text("Title"),
        TextField(
          maxLines: 1,
          controller: titleController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const Text("Note"),
        TextField(
          controller: noteController,
          maxLines: 50,
          minLines: 10,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ]),
    );
  }
}
