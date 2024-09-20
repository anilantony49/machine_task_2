import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_task_2/db/retail_shop_db.dart';
import 'package:machine_task_2/models/store.dart';

void showRouteDialog(
    BuildContext context, StoreModels? store, Function fetchStore) {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // Pre-fill the form fields with the selected driver's current details
  // If driver is null, it means we're adding a new driver, so clear the fields
  if (store == null) {
    nameController.clear();
    addressController.clear();
    numberController.clear();
  } else {
    // Pre-fill the form fields with the selected driver's current details
    nameController.text = store.name;
    addressController.text = store.address;
    numberController.text = store.contact;
  }

  String selectedImagePath = store?.image ?? '';

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
            title: Text(store == null ? 'Add Shop' : 'Edit Shop'),
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
                      labelText: 'Shop Name',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
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
                    final newShop = StoreModels(
                      id: store?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      contact: numberController.text,
                      address: addressController.text,
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

                    if (store == null) {
                      await StoreDb.singleton.addStore(newShop);
                    } else {
                      await StoreDb.singleton.editStore(newShop, newShop.id);
                    }
                    // widget.refreshDrivers();

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Store details add succesfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    nameController.clear();
                    addressController.clear();
                    numberController.clear();
                    // ignore: use_build_context_synchronously
                    FocusScope.of(context).unfocus();

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    fetchStore();
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
