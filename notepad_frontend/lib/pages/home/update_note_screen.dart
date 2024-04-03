// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/note/note_api.dart';
import 'package:notepad_frontend/models/note_model.dart';
import 'package:notepad_frontend/models/user_cubit.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/home/home.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late User user;
  late final Note note;
  @override
  void initState() {
    user = context.read<UserCubit>().state;
    note = widget.note;
    noteController.text = note.note;
    titleController.text = note.title;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
        actions: [
          OutlinedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  noteController.text.isNotEmpty) {
                note.note = noteController.text;
                note.title = titleController.text;
                var a = await updateNote(user, note);
                if (a != null) {
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertDialog(content: Text("Note Saved")),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertDialog(content: Text("Note not saved")),
                  );
                }
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            },
            child: const Text(
              "Exit",
              style: TextStyle(color: Colors.white),
            ),
          )
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
