import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _zipController = TextEditingController();
  String _result = "Noch keine PLZ gesucht";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _zipController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Postleitzahl",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: _searchCity,
                child: const Text("Suche"),
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Text(_result, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }

  void _searchCity() async {
    setState(() {
      _isLoading = true;
      _result = "Suche läuft...";
    });

    String zip = _zipController.text.trim();
    String city = await getCityFromZip(zip);

    setState(() {
      _isLoading = false;
      _result = "Ergebnis: $city";
    });
  }

  Future<String> getCityFromZip(String zip) async {
    await Future.delayed(const Duration(seconds: 3)); // Simulierte Wartezeit

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }

  @override
  void dispose() {
    _zipController.dispose(); // Controller freigeben
    super.dispose();
  }
}