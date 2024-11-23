import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewTaskScreen(),
    );
  }
}

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String repeatType = "Never"; 
  DateTime selectedDate = DateTime.now(); 
  bool isTillAlways = true; 
  TextEditingController dateController =
      TextEditingController(); 
  List<bool> daysSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Days selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Repeat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                // Show the repeat dialog and get the selected value
                final selectedRepeatType = await _showRepeatDialog(context);
                if (selectedRepeatType != null) {
                  setState(() {
                    repeatType = selectedRepeatType;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      repeatType,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showRepeatDialog(BuildContext context) {
    String localRepeatType = repeatType; // Local copy of repeatType
    return showDialog<String>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)), 
            ),
            titlePadding: const EdgeInsets.fromLTRB(125, 0, 12, 5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Repeat",style: TextStyle(color: (Color(0xFF0D47A1))),), 
                IconButton(
                  icon: const Icon(Icons.check, color: Color(0xFF0D47A1),size: 30,),
                  onPressed: () {
                    Navigator.of(context).pop(localRepeatType); // Return value
                  },
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        localRepeatType = "Never";
                        isTillAlways = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Never",style: TextStyle(fontSize: 18),),
                        Icon(
                          localRepeatType == "Never"
                              ? Icons.check
                              : null, // Show tick if selected
                          color: const Color(0xFF0486FF),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        localRepeatType = "Days";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Days",style: TextStyle(fontSize: 18),),
                        Icon(
                          localRepeatType == "Days"
                              ? Icons.check
                              : null, // Show tick if selected
                          color: const Color(0xFF0486FF),
                        ),
                      ],
                    ),
                  ),
                ),
                if (localRepeatType == "Days")
                  Wrap(
                    spacing: 8,
                    children: List.generate(7, (index) {
                      final days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
                      return ChoiceChip(
                        label: Text(
                          days[index],
                          style: TextStyle(
                            color: daysSelected[index]
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        selected: daysSelected[index],
                        onSelected: (selected) {
                          setState(() {
                            daysSelected[index] = selected;
                          });
                        },
                        shape: const CircleBorder(),
                        selectedColor: Colors.blue,
                        backgroundColor: const Color(0xFF004177),
                        showCheckmark: false,
                      );
                    }),
                  ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        localRepeatType = "Monthly";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Monthly",style: TextStyle(fontSize: 18),),
                        Icon(
                          localRepeatType == "Monthly"
                              ? Icons.check
                              : null, // Show tick if selected
                          color: const Color(0xFF0486FF),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        localRepeatType = "Yearly";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Yearly",style: TextStyle(fontSize: 18),),
                        Icon(
                          localRepeatType == "Yearly"
                              ? Icons.check
                              : null, // Show tick if selected
                          color: const Color(0xFF0486FF),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 250, 8),
                  child: Text(
                    "Till",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 44, 111),
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isTillAlways,
                            onChanged: (value) {
                              setState(() {
                                isTillAlways = value!;
                              });
                            },
                          ),
                          const Text(
                            "Always",
                            style: TextStyle(fontSize: 18,color: Color(0xFF004479)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: isTillAlways,
                            onChanged: (value) {
                              setState(() {
                                isTillAlways = !isTillAlways;
                              });
                            },
                          ),
                          const Text(
                            "Date",
                            style: TextStyle(fontSize: 18,color: Color(0xFF0D47A1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isTillAlways) // Only show the date picker if Date is selected
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDate,
                      onDateTimeChanged: (date) {
                        setState(() {
                          selectedDate = date;
                          dateController.text =
                              DateFormat.yMMMMd().format(selectedDate);
                        });
                      },
                    ),
                  ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
