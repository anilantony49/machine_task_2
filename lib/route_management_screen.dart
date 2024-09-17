  import 'package:flutter/material.dart';
  import 'package:machine_task_2/db/driver_db.dart';
  import 'package:machine_task_2/db/retail_shop_db.dart';
  import 'package:machine_task_2/db/route_db.dart';
  import 'models/route.dart';
  import 'models/driver.dart';
  import 'models/store.dart';

  class RouteManagementPage extends StatefulWidget {
    const RouteManagementPage({super.key});

    @override
    State<RouteManagementPage> createState() => _RouteManagementPageState();
  }

  class _RouteManagementPageState extends State<RouteManagementPage> {
    List<DriverModels> drivers = [];
    List<StoreModels> stores = [];
    List<RouteModels> routes = [];

    @override
    void initState() {
      super.initState();
      fetchRoute();
      fetchDriver();
      fetchStore();
    }

    void fetchRoute() async {
      List<RouteModels> fetchedItems = await RouteDb.singleton.getRoutes();
      setState(() {
        routes = fetchedItems;
      });
    }

    Future<void> fetchDriver() async {
      List<DriverModels> fetchedItems = await DriverDb.singleton.getDrivers();
      fetchedItems
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      setState(() {
        drivers = fetchedItems;
      });
    }

    Future<void> fetchStore() async {
      List<StoreModels> fetchedItems = await StoreDb.singleton.getStore();
      fetchedItems
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      setState(() {
        stores = fetchedItems;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Route Management',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
          actions: [
            TextButton(
              onPressed: () {
                _showRouteDialog(context, null);
              },
              child: const Text(
                'Add Route',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: routes.length,
                itemBuilder: (context, index) {
                  final route = routes[index];
                  return ListTile(
                    title: Text(route.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Driver: ${route.driver.name}'),
                        Text(
                            'Stores: ${route.stores.map((store) => store.name).join(', ')}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showRouteDialog(context, route);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Navigate to edit driver page
                            _showDeleteConfirmationDialog(context, route);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    void _showRouteDialog(BuildContext context, RouteModels? route) {
      final isEditing = route != null;
      final routeNameController = TextEditingController(
          text: isEditing ? route.name : null); // Prepopulate for editing
      DriverModels? selectedDriver = isEditing ? route.driver : null;
      List<StoreModels> selectedStores = isEditing ? route.stores : [];
      final formKey = GlobalKey<FormState>();
      bool isFormSubmitted = false;
      bool isStoreFormSubmitted = false;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(isEditing ? 'Edit Route' : 'Add Route'),
            content: Form(
              key: formKey,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Route Name Field
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Route Name is required';
                          }
                          return null;
                        },
                        controller: routeNameController,
                        decoration:
                            const InputDecoration(labelText: 'Route Name'),
                      ),
                      const SizedBox(height: 10),

                      // Driver Selection
                      InputDecorator(
                        decoration: InputDecoration(
                          errorText: isFormSubmitted && selectedDriver == null
                              ? 'Driver is required'
                              : null,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<DriverModels>(
                            isExpanded: true,
                            hint: const Text('Select Driver'),
                            value: selectedDriver,
                            onChanged: (DriverModels? newValue) {
                              setState(() {
                                selectedDriver = newValue;
                              });
                            },
                            items: drivers.map((DriverModels driver) {
                              return DropdownMenuItem<DriverModels>(
                                value: driver,
                                child: Text(driver.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Store Selection
                      InputDecorator(
                        decoration: InputDecoration(
                          errorText:
                              isStoreFormSubmitted && selectedStores.isEmpty
                                  ? 'Store selection is required'
                                  : null,
                        ),
                        child: ListTile(
                          title: const Text('Select Stores'),
                          subtitle: Text(
                            selectedStores.isEmpty
                                ? 'No store selected'
                                : selectedStores
                                    .map((store) => store.name)
                                    .join(', '),
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () async {
                            final updatedStores = await _showMultiSelectDialog(
                                context, selectedStores);
                            if (updatedStores != null) {
                              setState(() {
                                selectedStores = updatedStores;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isFormSubmitted = true;
                    isStoreFormSubmitted = true;
                  });

                  if (formKey.currentState!.validate() &&
                      selectedDriver != null &&
                      selectedStores.isNotEmpty) {
                    // Create or edit the route
                    final newRoute = RouteModels(
                      id: route?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      name: routeNameController.text,
                      driver: selectedDriver!,
                      stores: selectedStores,
                    );

                    if (route == null) {
                      // Add new route
                      await RouteDb.singleton.addRoute(newRoute);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('New Route added successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // Edit existing route
                      await RouteDb.singleton.editRoute(newRoute, route.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Route updated successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    // Clear fields after successful save
                    routeNameController.clear();
                    selectedDriver = null;
                    selectedStores = [];

                    Navigator.pop(context);
                    fetchRoute();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    Future<List<StoreModels>?> _showMultiSelectDialog(
        BuildContext context, List<StoreModels> selectedStores) async {
      List<StoreModels> tempSelectedStores = List.from(selectedStores);

      return await showDialog<List<StoreModels>>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Select Stores'),
                content: SingleChildScrollView(
                  child: Column(
                    children: stores.map((StoreModels store) {
                      return CheckboxListTile(
                        title: Text(store.name),
                        value: tempSelectedStores.contains(store),
                        onChanged: (bool? isChecked) {
                          setState(() {
                            if (isChecked == true) {
                              tempSelectedStores.add(store);
                            } else {
                              tempSelectedStores.remove(store);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, tempSelectedStores);

                      // Pass the updated stores back
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    void _showDeleteConfirmationDialog(BuildContext context, RouteModels routes) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Route"),
            content: const Text("Are you sure you want to delete this Route?"),
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
                  await RouteDb.singleton.deleteRoute(routes.id);

                  // widget.refreshDrivers(); // Refresh the list after deletion
                  Navigator.of(context).pop();
                  fetchRoute(); // Close the dialog after deletion
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
