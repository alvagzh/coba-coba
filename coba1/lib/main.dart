import 'package:flutter/material.dart';
import 'https://drive.google.com/file/d/1Tk-fkOLefY-b0SJc3TqTWuF3t6pWkjNH/view?usp=sharing';

void main() {
  runApp(MyApp());
}

class Game {
  final String title;
  final String cover;
  final String description;
  final String genre;
  final String releaseDate;
  final double price;
  final int reviews;

  Game({
    required this.title,
    required this.cover,
    required this.description,
    required this.genre,
    required this.releaseDate,
    required this.price,
    required this.reviews,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameListPage(),
    );
  }
}

class GameListPage extends StatelessWidget {
  final List<Game> games = [
    Game(
      title: 'Title 1',
      cover: 'cover1.jpg',
      description: 'Description 1',
      genre: 'Action',
      releaseDate: '2023-01-01',
      price: 19.99,
      reviews: 100,
    ),
    Game(
      title: 'Title 2',
      cover: 'cover2.jpg',
      description: 'Description 2',
      genre: 'Adventure',
      releaseDate: '2023-02-01',
      price: 24.99,
      reviews: 150,
    ),
    // Add more games here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Catalog'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailPage(game: games[index]),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/${games[index].cover}'),
                  ListTile(
                    title: Text(games[index].title),
                    subtitle: Text('\$${games[index].price.toString()}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GameDetailPage extends StatelessWidget {
  final Game game;

  GameDetailPage({required this.game});

  void _launchURL() async {
    const url =
        'https://drive.google.com/file/d/1Tk-fkOLefY-b0SJc3TqTWuF3t6pWkjNH/view?usp=sharing'; // Ganti dengan URL toko game yang sesuai
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Tambahkan logika untuk mengubah status favorite
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/${game.cover}'),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${game.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Genre: ${game.genre}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Release Date: ${game.releaseDate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${game.price.toString()}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Reviews: ${game.reviews.toString()}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _launchURL,
                child: Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
