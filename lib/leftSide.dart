import 'package:flutter/material.dart';

class MainMenuLists extends StatefulWidget {
  const MainMenuLists({super.key});

  @override
  State<MainMenuLists> createState() => _MainMenuListsState();
}

class _MainMenuListsState extends State<MainMenuLists> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Icon(
              Icons.memory,
              color: const Color.fromARGB(255, 21, 93, 252),
              size: 70.0,
              semanticLabel: 'VRMicro',
            ),
            Text(
              "VRM Config Studio",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
                ),
            ),
            SizedBox(
              height: 50,
            ),
            buildDeviceButton(0, "Devices"),
            SizedBox(
              height: 5,
            ),
            buildConfigurationButton(1, "Configuration"),
          ],
        );
  }

  Widget buildDeviceButton(int index, String label) {

    final isActive = currentIndex == index;

    return Row(
              children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FilledButton.icon(
                      onPressed: () {
                        print(index);
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      icon: const Icon(Icons.memory, size: 24,),
                      label: const Text('Devices'),
                      iconAlignment: IconAlignment.start,
                      style: FilledButton.styleFrom(
                        textStyle: TextStyle(fontSize: 16),
                        foregroundColor: const Color.fromARGB(255, 168, 182, 183),
                        backgroundColor: isActive ? const Color.fromARGB(255, 39, 39, 42) : const Color.fromARGB(0, 39, 39, 42),
                        alignment: Alignment.centerLeft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                )
                )
              ]
            );
  }

  Widget buildConfigurationButton(int index, String label) {

    final isActive = currentIndex == index;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton.icon(
              onPressed: () {
                print(index);
                setState(() {
                  currentIndex = index;
                });
              },
              icon: const Icon(Icons.settings, size: 20,),
              label: const Text('Configuration'),
              iconAlignment: IconAlignment.start,
              style: FilledButton.styleFrom(
                textStyle: TextStyle(fontSize: 16),
                foregroundColor: const Color.fromARGB(255, 168, 182, 183),
                backgroundColor: isActive ? const Color.fromARGB(255, 39, 39, 42) : const Color.fromARGB(0, 39, 39, 42),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        )
      ]
    );
  }
}