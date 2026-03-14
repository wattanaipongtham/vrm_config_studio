import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/newProjectForm.dart';

enum MenuEntry {
  newProject('New Project'),
  openExistProject('Open Exist Project'),
  save('Save'),
  saveAs('Save As'),
  exit('Exit');

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

  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  String selectedPath = "";

  @override
  Widget build(BuildContext context) {
    return Row(
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
    switch (selection) {
      case MenuEntry.newProject:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewProjectFormWidget(
                initialPath:selectedPath,
                onPathSelected: (path) {
                  selectedPath = path;
        },
              );
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
    }
  }

}

class RunMenuState extends State<RunMenu> {
  RunMenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  ShortcutRegistryEntry? _shortcutsEntry;

  @override
  Widget build(BuildContext context) {
    return Row(
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