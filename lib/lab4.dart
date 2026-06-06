import 'package:flutter/material.dart';

void runLab4() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 Flutter UI Fundamentals',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI Fundamentals'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Exercise 1 - Core Widgets'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CoreWidgetsDemo(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Exercise 2 - Input Widgets'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InputControlsDemo(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Exercise 3 - Layout Demo'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LayoutDemo(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Exercise 4 - App Structure & Theme'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ThemeDemo(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Exercise 5 - Common UI Fixes'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FixDemo(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            const Icon(
              Icons.movie,
              size: 60,
              color: Colors.blue,
            ),

            const SizedBox(height: 16),

            Image.network(
              'https://picsum.photos/300/200',
              height: 200,
            ),

            const SizedBox(height: 16),

            const Card(
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text('Movie Item'),
                subtitle: Text(
                  'This is a sample ListTile inside a Card',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() =>
      _InputControlsDemoState();
}

class _InputControlsDemoState
    extends State<InputControlsDemo> {
  double rating = 50;
  bool active = false;
  String genre = 'Action';
  DateTime? selectedDate;

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Rating: ${rating.toInt()}'),

            Slider(
              value: rating,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text('Active'),
              value: active,
              onChanged: (value) {
                setState(() {
                  active = value;
                });
              },
            ),

            RadioListTile(
              title: const Text('Action'),
              value: 'Action',
              groupValue: genre,
              onChanged: (value) {
                setState(() {
                  genre = value!;
                });
              },
            ),

            RadioListTile(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: genre,
              onChanged: (value) {
                setState(() {
                  genre = value!;
                });
              },
            ),

            ElevatedButton(
              onPressed: pickDate,
              child: const Text('Open Date Picker'),
            ),

            const SizedBox(height: 10),

            Text(
              selectedDate == null
                  ? 'No Date Selected'
                  : selectedDate.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      'Avatar',
      'Inception',
      'Interstellar',
      'Joker'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Now Playing',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          movies[index][0],
                        ),
                      ),
                      title: Text(movies[index]),
                      subtitle: const Text(
                        'Sample description',
                      ),
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

class ThemeDemo extends StatefulWidget {
  const ThemeDemo({super.key});

  @override
  State<ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 4'),
          actions: [
            Switch(
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            )
          ],
        ),
        body: const Center(
          child: Text(
            'This is a simple screen with theme toggle.',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class FixDemo extends StatelessWidget {
  const FixDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      'Movie A',
      'Movie B',
      'Movie C',
      'Movie D'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Correct ListView inside Column using Expanded',
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movies[index]),
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