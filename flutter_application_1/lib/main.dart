import 'package:flutter/material.dart';
import './models/news_model.dart';
import './api/mock_news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 234, 233, 236)),
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Assignment 1 UI'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              PhotoWidget(),
              ListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400,
          // height: 100,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s News',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Wed, 08 January 2020',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 129, 127, 127)),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250,
                width: 400,
                child: FutureBuilder<List<NewsModel>>(
                  future: readJsonData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No data available');
                    } else {
                      return ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 12,
                        ),
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          var news = snapshot.data![index];
                          return GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 250,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(news.image.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    news.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Text(
                                  news.published_time.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 129, 127, 127),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hot News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 129, 127, 127),
                    ),
                  ),
                ],
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: const Text(
                  'Central Java\'s Mount Merapi spews hot ash again',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Wed, 08 January 2020 | 3 hours ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 129, 127, 127),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
