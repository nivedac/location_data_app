import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/location_model.dart';

class EditLocationBottomSheet extends StatefulWidget {
  final LocationModel location;
  final Function(LocationModel) onSave;

  const EditLocationBottomSheet({
    super.key,
    required this.location,
    required this.onSave,
  });

  @override
  State<EditLocationBottomSheet> createState() =>
      _EditLocationBottomSheetState();
}

class _EditLocationBottomSheetState extends State<EditLocationBottomSheet> {
  late TextEditingController placeController;
  late TextEditingController countryController;
  late TextEditingController latController;
  late TextEditingController longController;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController(text: widget.location.placeName);
    countryController = TextEditingController(text: widget.location.country);
    latController =
        TextEditingController(text: widget.location.latitude.toString());
    longController =
        TextEditingController(text: widget.location.longitude.toString());
  }

  Future<void> updateLocation() async {
    setState(() => isSaving = true);
    final updated = LocationModel(
      id: widget.location.id,
      placeName: placeController.text,
      country: countryController.text,
      latitude: double.tryParse(latController.text) ?? 0.0,
      longitude: double.tryParse(longController.text) ?? 0.0,
    );

    final url = Uri.parse('http://192.168.1.2:3000/locations/${updated.id}');
final response = await http.put(
  url,
  headers: {'Content-Type': 'application/json'},
  body: json.encode(updated.toJson()),
);
    //final url = Uri.parse('http://192.168.1.2:3000/locations/${updated.id}');


    if (response.statusCode == 200) {
      widget.onSave(updated);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update location')),
      );
    }

    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Edit Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: placeController,
            decoration: const InputDecoration(labelText: "Place Name"),
          ),
          TextField(
            controller: countryController,
            decoration: const InputDecoration(labelText: "Country"),
          ),
          TextField(
            controller: latController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Latitude"),
          ),
          TextField(
            controller: longController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Longitude"),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: isSaving ? null : updateLocation,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: isSaving
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Save"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
