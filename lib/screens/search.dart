import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/data_search.dart';

class YearDetailsScreen extends StatefulWidget {
  final String year;

  const YearDetailsScreen({super.key, required this.year});

  @override
  State<YearDetailsScreen> createState() => _YearDetailsScreenState();
}

class _YearDetailsScreenState extends State<YearDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year} Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Details for ${widget.year}'),
      ),
    );
  }
}
