class Movie {
  final String index;
  final String title;
  final String description;
  final String image;

  const Movie(this.index, this.title, this.description, this.image);
}

final List<Movie> movies = _movies
    .map((e) => Movie(e['index'], e['title'], e['description'], e['image']))
    .toList();

final List<Map<String, String>> _movies = [
  {
    'index': '1',
    'title': 'Inception',
    'description':
        'Cobb steals information from his targets by entering their dreams. Saito offers to wipe clean Cobb\'s criminal history as payment for performing an inception on his sick competitor\'s son.',
    'image': 'images/inception.jpg',
  },
  {
    'index': '2',
    'title': 'Interstellar',
    'description':
        'In the future, where Earth is becoming uninhabitable, farmer and ex-NASA pilot Cooper is asked to pilot a spacecraft along with a team of researchers to find a new planet for humans.',
    'image': 'images/interstellar.png',
  },
  {
    'index': '3',
    'title': 'Deadpool',
    'description':
        'Ajax, a twisted scientist, experiments on Wade Wilson, a mercenary, to cure him of cancer and give him healing powers. However, the experiment leaves Wade disfigured and he decides to exact revenge.',
    'image': 'images/deadpool.jpg',
  },
  {
    'index': '4',
    'title': 'John Wick',
    'description':
        'Keanu Reeves plays John Wick, a retired hitman seeking vengeance for the killing of the dog given to him by his recently deceased wife, and for stealing his car.',
    'image': 'images/john_wick.jpg',
  },
  {
    'index': '5',
    'title': 'Tenet',
    'description':
        'A secret agent is given a single word as his weapon and sent to prevent the onset of World War III. He must travel through time and bend the laws of nature in order to be successful in his mission.',
    'image': 'images/tenet.jpg',
  },
  {
    'index': '6',
    'title': 'Joker',
    'description':
        'Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he\'s part of the world around him. ',
    'image': 'images/joker.jpg',
  },
  {
    'index': '7',
    'title': 'The Nun',
    'description':
        'When a young nun at a cloistered abbey in Romania takes her own life, a priest with a haunted past and a novitiate on the threshold of her final vows are sent by the Vatican to investigate.',
    'image': 'images/the_nun.jpg',
  },
];
