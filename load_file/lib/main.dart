import 'package:flutter/material.dart';
import 'package:load_file/services/fetch_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catch Error',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Catch Error'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String assetName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      onChanged: (val) {
                        assetName = val;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.zero,
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.zero,
                          ),
                          borderSide: BorderSide(width: 3, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.black),
                        ),
                        label: Text('Файл'),
                        hintText: 'Введите название файла',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.circular(7.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.circular(7.0),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('Найти'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (assetName != '')
            Expanded(
              child: FutureBuilder(
                  future: fetchFileFromAssets('assets/$assetName.txt'),
                  builder: (context, snapshot) {
                    return switch (snapshot.connectionState) {
                      ConnectionState.waiting => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ConnectionState.done => Center(
                          child: Text('${snapshot.data}'),
                        ),
                      ConnectionState.active => const Center(
                          child: Text('процесс активен'),
                        ),
                      ConnectionState.none => const Center(
                          child: Text('ошибка'),
                        ),
                    };
                  }),
            ),
        ],
      ),
    );
  }
}
