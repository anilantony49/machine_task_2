// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:machine_task_2/models/driver.dart';
// import 'package:machine_task_2/models/route.dart';
// import 'package:machine_task_2/models/store.dart';

// void showRouteDialog(BuildContext context, RouteModels? route) {
//     final isEditing = route != null;
//     final routeNameController = TextEditingController(
//         text: isEditing ? route.name : null); // Prepopulate for editing
//     DriverModels? selectedDriver = isEditing ? route.driver : null;
//     List<StoreModels> selectedStores = isEditing ? route.stores : [];
//     final formKey = GlobalKey<FormState>();
//     bool isFormSubmitted = false;
//     bool isStoreFormSubmitted = false;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(isEditing ? 'Edit Route' : 'Add Route'),
//           content: Form(
//             key: formKey,
//             child: StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Route Name Field
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Route Name is required';
//                         }
//                         return null;
//                       },
//                       controller: routeNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'Route Name'),
//                     ),
//                     const SizedBox(height: 10),

//                     // Driver Selection
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         errorText: isFormSubmitted && selectedDriver == null
//                             ? 'Driver is required'
//                             : null,
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<DriverModels>(
//                           isExpanded: true,
//                           hint: const Text('Select Driver'),
//                           value: selectedDriver,
//                           onChanged: (DriverModels? newValue) {
//                             setState(() {
//                               selectedDriver = newValue;
//                             });
//                           },
//                           items: drivers.map((DriverModels driver) {
//                             return DropdownMenuItem<DriverModels>(
//                               value: driver,
//                               child: Text(driver.name),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     // Store Selection
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         errorText:
//                             isStoreFormSubmitted && selectedStores.isEmpty
//                                 ? 'Store selection is required'
//                                 : null,
//                       ),
//                       child: ListTile(
//                         title: const Text('Select Stores'),
//                         subtitle: Text(
//                           selectedStores.isEmpty
//                               ? 'No store selected'
//                               : selectedStores
//                                   .map((store) => store.name)
//                                   .join(', '),
//                         ),
//                         trailing: const Icon(Icons.arrow_drop_down),
//                         onTap: () async {
//                           final updatedStores = await _showMultiSelectDialog(
//                               context, selectedStores);
//                           if (updatedStores != null) {
//                             setState(() {
//                               selectedStores = updatedStores;
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 setState(() {
//                   isFormSubmitted = true;
//                   isStoreFormSubmitted = true;
//                 });

//                 if (formKey.currentState!.validate() &&
//                     selectedDriver != null &&
//                     selectedStores.isNotEmpty) {
//                   // Create or edit the route
//                   final newRoute = RouteModels(
//                     id: route?.id ??
//                         DateTime.now().millisecondsSinceEpoch.toString(),
//                     name: routeNameController.text,
//                     driver: selectedDriver!,
//                     stores: selectedStores,
//                   );

//                   if (route == null) {
//                     // Add new route
//                     await RouteDb.singleton.addRoute(newRoute);
//                     // ignore: use_build_context_synchronously
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('New Route added successfully'),
//                         duration: Duration(seconds: 2),
//                       ),
//                     );
//                   } else {
//                     // Edit existing route
//                     await RouteDb.singleton.editRoute(newRoute, route.id);
//                     // ignore: use_build_context_synchronously
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Route updated successfully'),
//                         duration: Duration(seconds: 2),
//                       ),
//                     );
//                   }

//                   // Clear fields after successful save
//                   routeNameController.clear();
//                   selectedDriver = null;
//                   selectedStores = [];

//                   // ignore: use_build_context_synchronously
//                   Navigator.pop(context);
//                   fetchRoute();
//                 }
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<List<StoreModels>?> _showMultiSelectDialog(
//       BuildContext context, List<StoreModels> selectedStores) async {
//     List<StoreModels> tempSelectedStores = List.from(selectedStores);

//     return await showDialog<List<StoreModels>>(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Select Stores'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: stores.map((StoreModels store) {
//                     return CheckboxListTile(
//                       title: Text(store.name),
//                       value: tempSelectedStores.contains(store),
//                       onChanged: (bool? isChecked) {
//                         setState(() {
//                           if (isChecked == true) {
//                             tempSelectedStores.add(store);
//                           } else {
//                             tempSelectedStores.remove(store);
//                           }
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, tempSelectedStores);

//                     // Pass the updated stores back
//                   },
//                   child: const Text('Ok'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }