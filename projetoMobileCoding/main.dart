import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF4B0082), // Roxo escuro
        primaryColor: const Color(0xFF6A5ACD), // Roxo claro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6A5ACD), // Cor do AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIconColor: Colors.white70,
        ),
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
      'temperature': '27°',
      'highLow': 'H: 30°C  E: 27°C',
      'city': 'Maceió, AL',
      'weather': 'Chuvoso',
      'icon': Icons.cloud,
    },
    {
      'temperature': '22°',
      'highLow': 'H: 28°C  E: 20°C',
      'city': 'Campina Grande - Paraíba',
      'weather': 'Chuvoso',
      'icon': Icons.cloud,
    },
    {
      'temperature': '18°',
      'highLow': 'H: 23°C  E: 17°C',
      'city': 'Joinville - Santa Catarina',
      'weather': 'Chuvoso',
      'icon': Icons.cloud,
    },
    {
      'temperature': '28°',
      'highLow': 'H: 36°C  E: 24°C',
      'city': 'Palmas - Tocantins',
      'weather': 'Clima Tropical',
      'icon': Icons.wb_sunny,
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
        title: const Text('Clima'),
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
                hintText: 'Procure pela sua cidade',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Ação do botão "Voltar"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isHovered ? Colors.white24 : Colors.white10,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (_isHovered)
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Row(
          children: [
            Icon(widget.icon, size: 40, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.temperature,
                    style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.highLow,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    widget.city,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    widget.weather,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
