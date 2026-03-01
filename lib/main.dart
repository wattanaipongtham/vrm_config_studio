import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

enum MenuEntry {
  newProject('New Project'),
  openExistProject('Open Exist Project'),
  save('Save'),
  saveAs('Save As'),
  exit('Exit'),
  showMessage(
    'Show Message',
    SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ),
  hideMessage(
    'Hide Message',
    SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ),
  colorMenu('Color Menu'),
  colorRed(
    'Red Background',
    SingleActivator(LogicalKeyboardKey.keyR, control: true),
  ),
  colorGreen(
    'Green Background',
    SingleActivator(LogicalKeyboardKey.keyG, control: true),
  ),
  colorBlue(
    'Blue Background',
    SingleActivator(LogicalKeyboardKey.keyB, control: true),
  );

  const MenuEntry(this.label, [this.shortcut]);
  final String label;
  final MenuSerializableShortcut? shortcut;
}

enum RunMenuEntry {
  newProject('New Project'),
  openExistProject('Open Exist Project'),
  save('Save'),
  saveAs('Save As'),
  exit('Exit');

  const RunMenuEntry(this.label, [this.shortcut]);
  final String label;
  final MenuSerializableShortcut? shortcut;
}


void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: [LeftSide(), RightSide()],
          ),
        ),
      ),
    );
  }
}

const sidebarColor = Color.fromARGB(255, 202, 240, 248);

class LeftSide extends StatelessWidget {
  LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: Container(
            color: sidebarColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: 
                Row(
                children: [
                  MyCascadingMenu(message: "Hello world"),
                  RunMenu(message: "Hello world2"),
                  Expanded(child: MoveWindow()),
                ]
                ),
            )],
            )));
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
   RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: sidebarColor,
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          )
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key, required this.message});

  final String message;

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}
class RunMenu extends StatefulWidget {
  const RunMenu({super.key, required this.message});

  final String message;

  @override
  State<RunMenu> createState() => RunMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  MenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  ShortcutRegistryEntry? _shortcutsEntry;

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showingMessage;
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              child: Text(MenuEntry.newProject.label),
              onPressed: () => _activate(MenuEntry.newProject),
            ),
            MenuItemButton(
              child: Text(MenuEntry.openExistProject.label),
              onPressed: () => _activate(MenuEntry.openExistProject),
            ),
            MenuItemButton(
              child: Text(MenuEntry.save.label),
              onPressed: () => _activate(MenuEntry.save),
            ),
            MenuItemButton(
              child: Text(MenuEntry.saveAs.label),
              onPressed: () => _activate(MenuEntry.saveAs),
            ),
            MenuItemButton(
              child: Text(MenuEntry.exit.label),
              onPressed: () => _activate(MenuEntry.exit),
            ),
            if (_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                shortcut: MenuEntry.hideMessage.shortcut,
                child: Text(MenuEntry.hideMessage.label),
              ),
            if (!_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.showMessage),
                shortcut: MenuEntry.showMessage.shortcut,
                child: Text(MenuEntry.showMessage.label),
              ),
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorRed),
                  shortcut: MenuEntry.colorRed.shortcut,
                  child: Text(MenuEntry.colorRed.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorGreen),
                  shortcut: MenuEntry.colorGreen.shortcut,
                  child: Text(MenuEntry.colorGreen.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorBlue),
                  shortcut: MenuEntry.colorBlue.shortcut,
                  child: Text(MenuEntry.colorBlue.label),
                ),
              ],
              child: const Text('Background Color'),
            ),
          ],
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
                return TextButton(
                  focusNode: _buttonFocusNode,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: const Text('File'),
                );
              },
        ),
        
      ],
    );
  }

  void _activate(MenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case MenuEntry.newProject:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewProjectFormWidget();
            },
          );
      case MenuEntry.openExistProject:
        break;
      case MenuEntry.save:
        break;
      case MenuEntry.saveAs:
        break;
      case MenuEntry.exit:
        break;
      case MenuEntry.hideMessage:
      case MenuEntry.showMessage:
        showingMessage = !showingMessage;
      case MenuEntry.colorMenu:
        break;
      case MenuEntry.colorRed:
        backgroundColor = Colors.red;
      case MenuEntry.colorGreen:
        backgroundColor = Colors.green;
      case MenuEntry.colorBlue:
        backgroundColor = Colors.blue;
    }
  }
}

class RunMenuState extends State<RunMenu> {
  RunMenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  ShortcutRegistryEntry? _shortcutsEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              child: Text(RunMenuEntry.newProject.label),
              onPressed: () => _activate(RunMenuEntry.newProject),
            ),
            MenuItemButton(
              child: Text(RunMenuEntry.openExistProject.label),
              onPressed: () => _activate(RunMenuEntry.openExistProject),
            ),
            MenuItemButton(
              child: Text(RunMenuEntry.save.label),
              onPressed: () => _activate(RunMenuEntry.save),
            ),
            MenuItemButton(
              child: Text(RunMenuEntry.saveAs.label),
              onPressed: () => _activate(RunMenuEntry.saveAs),
            ),
            MenuItemButton(
              child: Text(RunMenuEntry.exit.label),
              onPressed: () => _activate(RunMenuEntry.exit),
            ),
          ],
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
                return TextButton(
                  focusNode: _buttonFocusNode,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: const Text('Run'),
                );
              },
        ),
        
      ],
    );
  }

  void _activate(RunMenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case RunMenuEntry.newProject:
        break;
      case RunMenuEntry.openExistProject:
        break;
      case RunMenuEntry.save:
        break;
      case RunMenuEntry.saveAs:
        break;
      case RunMenuEntry.exit:
        break;
    }
  }
}

class NewProjectFormWidget extends StatefulWidget {
  @override
  _NewProjectFormWidgetState createState() => _NewProjectFormWidgetState();
}

class _NewProjectFormWidgetState extends State<NewProjectFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  TimeOfDay? _reminderTime;
  String? _newCategory;
  final List<String> _categories = ['Personal', 'Work', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(6, 6),
                spreadRadius: 2,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
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
                    "Add Task",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _category,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    isExpanded: true,
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _category = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                  ),
                ),
                if (_category == 'Other') ...[
                  const SizedBox(height: 16),
                  const Text(
                    "Add Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {
                      _newCategory = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a category' : null,
                  ),
                ],
                const SizedBox(height: 16),
                const Text(
                  "Task",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {},
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a task title' : null,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Reminder Timing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _reminderTime ?? TimeOfDay.now(),
                    );

                    if (pickedTime != null && pickedTime != _reminderTime) {
                      setState(() {
                        _reminderTime = pickedTime;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: _reminderTime == null
                        ? ''
                        : _reminderTime!.format(context),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please pick a reminder time' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_category == 'Other' &&
                            _newCategory != null &&
                            _newCategory!.isNotEmpty) {
                          _categories.add(_newCategory!);
                          _category = _newCategory;
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:WidgetStatePropertyAll<Color>(Colors.green),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}