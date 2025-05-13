import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  final List<Map<String, dynamic>> adminItems = const [
    {
      'title': 'Usuários',
      'icon': Icons.people,
      'color': Colors.green,
      'route': '/users',
    },
    {
      'title': 'Relatório',
      'icon': Icons.assessment,
      'color': Colors.blue,
      'route': '/relatorios',
    },
    {
      'title': 'Configurações',
      'icon': Icons.settings,
      'color': Colors.grey,
      'route': '/config',
    },
  ];

  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        final routeName = item['route'] as String?;
        if (routeName != null && routeName.isNotEmpty) {
          Navigator.of(context).pushNamed(routeName);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: item['color'] ?? Colors.teal,
                child: Icon(
                  item['icon'] as IconData?,
                  size: 50,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  item['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('Fluxo Livre - ADMIN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
             if (Navigator.canPop(context)) {
               Navigator.pop(context);
             }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.1,
          children: adminItems.map((item) => _buildGridItem(context, item)).toList(),
        ),
      ),
    );
  }
}