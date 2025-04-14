import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempo Agora',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark),
        scaffoldBackgroundColor: Colors.deepPurple.shade800,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade700,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: true,
          elevation: 2,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.deepPurple.shade900.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.deepPurple.shade200),
          prefixIconColor: Colors.deepPurple.shade200,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.deepPurple.shade900,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          bodySmall: TextStyle(color: Colors.deepPurpleAccent),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final List<Map<String, dynamic>> _weatherData = [
    {
      'temperature': '27°C',
      'highLow': 'Máx: 30°C | Min: 27°C',
      'city': 'Maceió, AL',
      'weather': 'Chuvoso',
      'icon': Icons.cloudy_snowing,
    },
    {
      'temperature': '22°C',
      'highLow': 'Máx: 28°C | Min: 20°C',
      'city': 'Campina Grande, PB',
      'weather': 'Nublado com chuva',
      'icon': Icons.umbrella,
    },
    {
      'temperature': '18°C',
      'highLow': 'Máx: 23°C | Min: 17°C',
      'city': 'Joinville, SC',
      'weather': 'Chuva fraca',
      'icon': Icons.waves,
    },
    {
      'temperature': '31°C',
      'highLow': 'Máx: 36°C | Min: 24°C',
      'city': 'Palmas, TO',
      'weather': 'Ensolarado',
      'icon': Icons.sunny,
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = _weatherData.where((item) {
      final city = item['city']!.toLowerCase();
      return city.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempo Agora'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Buscar cidade...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return WeatherCard(
                  temperature: item['temperature'],
                  highLow: item['highLow'],
                  city: item['city'],
                  weather: item['weather'],
                  icon: item['icon'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: ElevatedButton(
              onPressed: () {
                // Ação do botão "Voltar"
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidade de voltar ainda não implementada.')),
                );
              },
              child: const Text('Voltar'),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherCard extends StatefulWidget {
  final String temperature;
  final String highLow;
  final String city;
  final String weather;
  final IconData icon;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.highLow,
    required this.city,
    required this.weather,
    required this.icon,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(widget.icon, size: 40, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.temperature,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.highLow,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.city,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        widget.weather,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
