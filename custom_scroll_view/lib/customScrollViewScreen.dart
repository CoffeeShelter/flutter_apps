import 'package:flutter/material.dart';

class CustomScrollViewScreen extends StatefulWidget {
  const CustomScrollViewScreen(
    {
      Key key,
      @required this.title,
    }
  ) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _CustomScrollViewScreenState();
}

class _CustomScrollViewScreenState extends State<CustomScrollViewScreen>{

  getColor(
    index,
  ) {
    final color = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return color[index % color.length];
  }

  renderSliverAppbar() {
    return const SliverAppBar(
      backgroundColor: Colors.black,
      title: Text(
        'Seoul'
      ),
    );
  }

  renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: getColor(index),
          );
        },
        childCount: 32,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
    );
  }

  renderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: getColor(index),
            height: 100.0,
          );
        },
        childCount: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderSliverGrid(),
          renderSliverList(),
          renderSliverGrid(),
          renderSliverList(),
        ],
      ),
    );
  }
  
}