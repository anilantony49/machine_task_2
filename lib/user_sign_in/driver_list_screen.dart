import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_task_2/db/driver_db.dart';
import 'package:machine_task_2/tab_view_items.dart';

import '../models/driver.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({
    super.key,
  });

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  List<DriverModels> drivers = [];

  @override
  void initState() {
    fetchDriver();
    super.initState();
  }

  void fetchDriver() async {
    List<DriverModels> fetchedItems = await DriverDb.singleton.getDrivers();
    setState(() {
      drivers = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                      onPressed: () {
                        _showRouteDialog(context, null);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            final driver = drivers[index];
            return Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Container(
                // width: double.infinity,
                // height: 80,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 177, 128, 128),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: driver.image != null &&
                            driver.image!.isNotEmpty
                        ? FileImage(
                            File(driver.image!)) // If image is stored locally
                        : const AssetImage('assets/images/blank_image.webp')
                            as ImageProvider,
                    radius: 30,
                  ),
                  title: Text(driver.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('age: ${driver.age}'),
                      Text('Contact no: ${driver.contact}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to edit driver page

                          _showRouteDialog(context, driver);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Navigate to edit driver page
                          _showDeleteConfirmationDialog(context, driver);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showRouteDialog(BuildContext context, DriverModels? driver) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final numberController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    // Pre-fill the form fields with the selected driver's current details
    // If driver is null, it means we're adding a new driver, so clear the fields
    if (driver == null) {
      nameController.clear();
      ageController.clear();
      numberController.clear();
    } else {
      // Pre-fill the form fields with the selected driver's current details
      nameController.text = driver.name;
      ageController.text = driver.age;
      numberController.text = driver.contact;
    }

    String selectedImagePath = driver?.image ?? '';

    Future pickImage(ImageSource source, StateSetter setState) async {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        selectedImagePath = image.path;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(driver == null ? 'Add Driver' : 'Edit Driver'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await pickImage(ImageSource.gallery, setState);
                      },
                      child: CircleAvatar(
                        backgroundImage: selectedImagePath.isNotEmpty
                            ? FileImage(File(selectedImagePath))
                            : const AssetImage('assets/images/blank_image.webp')
                                as ImageProvider<Object>,
                        radius: 60,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Driver Name',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Age is required';
                        }
                        return null;
                      },
                      controller: ageController,
                      decoration:
                          const InputDecoration(labelText: 'Driver Age'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contact number is required';
                        }
                        return null;
                      },
                      controller: numberController,
                      decoration:
                          const InputDecoration(labelText: 'Contact number'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Add driver logic

                    if (formKey.currentState!.validate()) {
                      final newDriver = DriverModels(
                        id: driver?.id ??
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text,
                        contact: numberController.text,
                        age: ageController.text,
                        image: selectedImagePath,
                      );

                      if (selectedImagePath.isEmpty) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Image is required'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      if (driver == null) {
                        await DriverDb.singleton.addDriver(newDriver);
                      } else {
                        await DriverDb.singleton
                            .editDriver(newDriver, driver.id);
                      }
                      // widget.refreshDrivers();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Driver details add succesfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      nameController.clear();
                      ageController.clear();
                      numberController.clear();
                      FocusScope.of(context).unfocus();

                      Navigator.pop(context);
                      fetchDriver();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DriverModels driver) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Driver"),
          content: const Text("Are you sure you want to delete this driver?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform the delete operation
                await DriverDb.singleton.deleteDriver(driver.id);

                // widget.refreshDrivers(); // Refresh the list after deletion
                Navigator.of(context).pop();
                fetchDriver(); // Close the dialog after deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Driver deleted successfully')),
                );
              },
              child: const Text("Delete"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
