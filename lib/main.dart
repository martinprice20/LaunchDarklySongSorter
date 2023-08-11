import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:launchdarkly_flutter_client_sdk/launchdarkly_flutter_client_sdk.dart';

import 'env/Song.dart';
import 'env/env.dart';

const String featureFlagKey = 'sort-by-date';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Osmium Launchdarkly Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Heavy Metal Playlist Sorter'),
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
  List<Song> library = SongUtils().getSongs();
  List<Song> _songs = [];
  bool showFeature = false;
  String message = 'initializing';

  @override
  void initState() {
    super.initState();
    _songs = library;

    LDConfig config = LDConfigBuilder(Env.mobileToken).build();

    LDContextBuilder builder = LDContextBuilder();
    builder.kind('martinprice20', 'martinprice20-key-123abc');
    LDContext context = builder.build();

    LDClient.startWithContext(config, context).whenComplete(() {
      updateFlagEvaluation();
      LDClient.registerFeatureFlagListener(
          featureFlagKey, updateFlagEvaluation);
    });
  }

  Future<void> updateFlagEvaluation([String? flagKey]) async {
    var result = await LDClient.boolVariation(featureFlagKey, false);
    setState(() {
      message = 'Feature "$featureFlagKey" evaluated to $result';
      showFeature = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  var dateAdded = DateFormat('MMM dd yyyy')
                      .format(DateTime.parse(_songs[index].dateAdded));
                  return Center(
                      child: Column(
                        children: [
                          Text('Name: ${_songs[index].name}'),
                          Text('Artist: ${_songs[index].artist}'),
                          Text('Added: $dateAdded'),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemCount: _songs.length),
          ),
          const SizedBox(
            height: 24,
          ),
          OutlinedButton(
              onPressed: sortByArtist, child: const Text('Sort by artist')),
          OutlinedButton(
              onPressed: sortByName, child: const Text('Sort by song name')),
          Visibility(
            visible: showFeature,
            child: OutlinedButton(
                onPressed: sortByDateAdded,
                child: const Text('Sort by date added')),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),

// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  sortByArtist() {
    setState(() {
      _songs.sort((a, b) => a.artist.compareTo(b.artist));
    });
  }

  sortByName() {
    setState(() {
      _songs.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  sortByDateAdded() {
    setState(() {
      _songs.sort((a, b) =>
          DateTime.parse(a.dateAdded).compareTo(DateTime.parse(b.dateAdded)));
    });
  }
}
