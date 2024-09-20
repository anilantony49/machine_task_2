  import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_task_2/db/driver_db.dart';
import 'package:machine_task_2/models/driver.dart';

void showRouteDialog(BuildContext context, DriverModels? driver,Function fetchDriver) {
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