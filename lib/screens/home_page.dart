// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/location_model.dart';
// import '../widgets/edit_location_bottom_sheet.dart';
// import 'map_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<LocationModel> locations = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchLocations();
//   }

//   Future<void> fetchLocations() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.1.2:3000/locations'));

//       if (response.statusCode == 200) {
//         final List data = json.decode(response.body);
//         setState(() {
//           locations = data.map((e) => LocationModel.fromJson(e)).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error fetching locations: $e');
//       setState(() => isLoading = false);
//     }
//   }

//   void _editLocation(LocationModel location) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return EditLocationBottomSheet(
//           location: location,
//           onSave: (updated) {
//             setState(() {
//               int index = locations.indexWhere((l) => l.id == updated.id);
//               locations[index] = updated;
//             });
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: Colors.black,
//         titleTextStyle: const TextStyle(fontSize: 30),
//       ),
//       backgroundColor: Colors.black,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Added text at the top of body
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'Location Data', // Text under the AppBar
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 // Existing ListView.builder unchanged
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(8),
//                     itemCount: locations.length,
//                     itemBuilder: (context, index) {
//                       final loc = locations[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text("${index + 1}. ${loc.placeName}, ${loc.country}"),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.edit, color: Colors.orange),
//                             onPressed: () => _editLocation(loc),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => MapPage(location: loc),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_model.dart';
import '../widgets/edit_location_bottom_sheet.dart';
import 'map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LocationModel> locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.2:3000/locations'));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          locations = data.map((e) => LocationModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching locations: $e');
      setState(() => isLoading = false);
    }
  }

  void _editLocation(LocationModel location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return EditLocationBottomSheet(
          location: location,
          onSave: (updated) {
            setState(() {
              int index = locations.indexWhere((l) => l.id == updated.id);
              locations[index] = updated;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(fontSize: 30),
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox.expand( // Ensure full height so AppBar shows on web
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text under the AppBar
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Location Data',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Existing ListView.builder wrapped in Expanded
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final loc = locations[index];
                        return Card(
                          child: ListTile(
                            title: Text("${index + 1}. ${loc.placeName}, ${loc.country}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () => _editLocation(loc),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MapPage(location: loc),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
