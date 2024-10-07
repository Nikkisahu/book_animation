import 'package:book_animation/my_design_dialog.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool horizontalView = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Animated Book List'),
        actions: [
          IconButton(
            onPressed: () => setState(() => horizontalView = !horizontalView),
            icon: Icon(
              horizontalView
                  ? Icons.view_column_rounded
                  : Icons.table_rows_rounded,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: horizontalView ? Axis.vertical : Axis.horizontal,
          children: [
            Text(
              horizontalView ? 'Books example:' : 'Books\nexample:',
              style: textTheme.headlineSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 225,
                width: 160,
                child: BooksExample(horizontalView: horizontalView),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
