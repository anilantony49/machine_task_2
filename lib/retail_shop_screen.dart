import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_task_2/db/retail_shop_db.dart';
import 'package:machine_task_2/models/store.dart';

class RetailShopScreen extends StatefulWidget {
  const RetailShopScreen({
    super.key,
  });

  @override
  State<RetailShopScreen> createState() => _RetailShopScreenState();
}

class _RetailShopScreenState extends State<RetailShopScreen> {
  List<StoreModels> stores = [];

  @override
  void initState() {
    fetchStore();
    super.initState();
  }

  void fetchStore() async {
    List<StoreModels> fetchedItems =
        await StoreDb.singleton.getStore();
    setState(() {
      stores = fetchedItems;
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
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final shop = stores[index];
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
                    backgroundImage:
                        shop.image != null && shop.image!.isNotEmpty
                            ? FileImage(
                                File(shop.image!)) // If image is stored locally
                            : const AssetImage('assets/images/blank_image.webp')
                                as ImageProvider,
                    radius: 30,
                  ),
                  title: Text(shop.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('address: ${shop.address}'),
                      Text('Contact no: ${shop.contact}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to edit driver page

                          _showRouteDialog(context, shop);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Navigate to edit driver page
                          _showDeleteConfirmationDialog(context, shop);
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

  void _showRouteDialog(BuildContext context, StoreModels? store) {
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
                        await StoreDb.singleton
                            .editStore(newShop, newShop.id);
                      }
                      // widget.refreshDrivers();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Store details add succesfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      nameController.clear();
                      addressController.clear();
                      numberController.clear();
                      FocusScope.of(context).unfocus();

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

  void _showDeleteConfirmationDialog(BuildContext context, StoreModels store) {
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
                await StoreDb.singleton.deleteStore(store.id);

                // widget.refreshDrivers(); // Refresh the list after deletion
                Navigator.of(context).pop();
                fetchStore(); // Close the dialog after deletion
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
