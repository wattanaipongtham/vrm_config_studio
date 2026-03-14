import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:io/io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class NewProjectFormWidget extends StatefulWidget {

  final String initialPath;
  final Function(String) onPathSelected;

  const NewProjectFormWidget({
    super.key,
    required this.initialPath,
    required this.onPathSelected,
  });

  @override
  _NewProjectFormWidgetState createState() => _NewProjectFormWidgetState();
}

class _NewProjectFormWidgetState extends State<NewProjectFormWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController pathController = TextEditingController();
  TextEditingController TargetFolderPathController = TextEditingController();

  Future<void> _pickFolder() async {

    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      pathController.text = result;
      widget.onPathSelected(result);
    }
  }

  @override
  void initState() {
    super.initState();
    pathController = TextEditingController(text: widget.initialPath);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:const Color.fromARGB(255, 255, 255, 255),
      insetPadding: EdgeInsets.zero,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
      child:FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.7,
        child:SingleChildScrollView(
          padding:EdgeInsets.all(20),
          child:Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: CloseButton(),
                  ),
                  const Center(
                    child: Text(
                      "New Project",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Project Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                  children: [
                    Expanded(
                      flex:12,
                      child:TextFormField(
                        controller: TargetFolderPathController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onChanged: (value) {},
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a task title' : null,
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child:const SizedBox(
                        height: 8),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  const Text(
                    "Project Directory",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child:TextFormField(
                          controller: pathController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onChanged: (value) {},
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a task title' : null,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child:IconButton(
                          icon: const Icon(Icons.folder_open),
                          onPressed: _pickFolder,
                        ),
                      ),
                  ]),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child:TextButton(
                          onPressed: (){
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("Cancel")
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child:TextButton(
                          onPressed: (){
                            copyFileExample(pathController.text);
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("Create"),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 0, 0, 0)),
                          ),
                        )
                      ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*Future<File> copyFileExample(String sourceFilePath, String destinationPath) async {
  try {
    final String newFilePath = p.join(destinationPath, "hello.txt");

    final File sourceFile = File(sourceFilePath);

    final File copiedFile = await sourceFile.copy(newFilePath);

    print('File copied from $sourceFilePath to $newFilePath');
    return copiedFile;
  } catch (e) {
    print('Error copying file: $e');
    rethrow;
  }
}*/
  Future<void> copyFileExample(String destinationPath) async {
  try {
    String sourcePath = Directory.current.path;
    print(sourcePath);
    await copyPath(sourcePath, destinationPath);
    print('Directory copied successfully from $sourcePath to $destinationPath');
  } on FileSystemException catch (e) {
    print('Error copying directory: $e');
  }
}