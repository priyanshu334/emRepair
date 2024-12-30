import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:em_repair/components/reciver_components/location_selection.dart';
import 'package:em_repair/components/reciver_components/operator_selection.dart';
import 'package:em_repair/components/reciver_components/receiver_feild.dart';
import 'package:em_repair/providers/list_provider.dart';

class ReceiverField extends StatefulWidget {
  final TextEditingController receiverController;
  final TextEditingController operatorController;

  const ReceiverField({
    Key? key,
    required this.operatorController,
    required this.receiverController,
  }) : super(key: key);

  @override
  State<ReceiverField> createState() => _ReceiverFieldState();
}

class _ReceiverFieldState extends State<ReceiverField> {
  final _formKey = GlobalKey<FormState>();
  bool _inHouse = false;
  bool _serviceCenter = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final listProvider = Provider.of<ListProvider>(context, listen: false);
    await listProvider.loadFromSharedPreferences();
    await listProvider.loadFromJsonFile();
  }

  void _onChanged(bool? value, String type) {
    setState(() {
      if (type == 'inHouse') {
        _inHouse = value ?? false;
        if (_inHouse) _serviceCenter = false;
      } else if (type == 'serviceCenter') {
        _serviceCenter = value ?? false;
        if (_serviceCenter) {
          _inHouse = false;
          _showServiceCenterDialog();
        }
      }
    });
  }

  void _showSelectOperatorDialog(List<String> operators) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedOperator;
        return AlertDialog(
          title: const Text("Select Operator"),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: operators.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  value: operators[index],
                  groupValue: selectedOperator,
                  title: Text(operators[index]),
                  onChanged: (value) {
                    setState(() {
                      selectedOperator = value;
                    });
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (selectedOperator != null) {
                  setState(() {
                    widget.operatorController.text = selectedOperator!;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Select"),
            ),
          ],
        );
      },
    );
  }

  void _showServiceCenterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime currentDate = _selectedDate ?? DateTime.now();
        TimeOfDay currentTime = _selectedTime ?? TimeOfDay.now();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Service Center Scheduling"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date: ${currentDate.toLocal().toString().split(' ')[0]}"),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              currentDate = pickedDate;
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        child: const Text("Select Date"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time: ${currentTime.format(context)}"),
                      ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: currentTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              currentTime = pickedTime;
                              _selectedTime = pickedTime;
                            });
                          }
                        },
                        child: const Text("Select Time"),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      if (!_inHouse && !_serviceCenter) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a location type')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validation successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReceiverTextField(
                      receiverController: widget.receiverController,

                    ),
                    const SizedBox(height: 10),
                    OperatorSelection(
                      operatorController: widget.operatorController,
                      operators: listProvider.entries
                          .map((entry) => entry['service'] as String)
                          .toList(),
                      onShowDialog: () => _showSelectOperatorDialog(
                        listProvider.entries
                            .map((entry) => entry['service'] as String)
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LocationSelection(
                      inHouse: _inHouse,
                      serviceCenter: _serviceCenter,
                      onInHouseChanged: (value) => _onChanged(value, 'inHouse'),
                      onServiceCenterChanged: (value) =>
                          _onChanged(value, 'serviceCenter'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _validateForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
