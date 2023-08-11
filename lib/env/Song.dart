class Song {
  String name;
  String artist;
  String dateAdded;

  Song({required this.name, required this.artist, required this.dateAdded});
}

class SongUtils {

  List<Song> _songs = [];

  static final SongUtils _instance = SongUtils._internal();

  factory SongUtils() {
    return _instance;
  }

  SongUtils._internal() {
    _songs = [
      Song(
          name: "Smoke On the Water",
          artist: "Deep Purple",
          dateAdded: "1974-01-01"),
      Song(
          name: "Kashmir",
          artist: "Led Zeppelin",
          dateAdded: "1974-01-03"),
      Song(
          name: "Since You\'ve Been Gone",
          artist: "Rainbow",
          dateAdded: "1980-03-19"),
      Song(
          name: "The Number Of The Beast",
          artist: "Iron Maiden",
          dateAdded: "1979-07-23"),
      Song(
          name: "The Ace Of Spades",
          artist: "M\u00F6torhead",
          dateAdded: "1984-05-17"),
      Song(
          name: "Bark At The Moon",
          artist: "Ozzy Osbourne",
          dateAdded: "1983-06-13"),
      Song(
          name: "Bring The Noise",
          artist: "Anthrax",
          dateAdded: "1991-06-23"),
      Song(
          name: "All We Are",
          artist: "Warlock",
          dateAdded: "1987-08-19"),
      Song(
          name: "Master Of Puppets",
          artist: "Metallica",
          dateAdded: "1997-11-29"),
      Song(
          name: "Cum On Feel the Noize",
          artist: "Quiet Riot",
          dateAdded: "1984-05-11"),
      Song(
          name: "Back In Black",
          artist: "AC/DC",
          dateAdded: "1989-01-03"),
      Song(
          name: "Holy Diver",
          artist: "Dio",
          dateAdded: "1975-07-09"),
      Song(
          name: "Photograph",
          artist: "Def Leppard",
          dateAdded: "1980-01-30"),
      Song(
          name: "Paranoid",
          artist: "Black Sabbath",
          dateAdded: "1972-02-24"),
      Song(
          name: "Breaking The Law",
          artist: "Judas Priest",
          dateAdded: "1981-10-16"),
    ];
  }

  List<Song> getSongs() {
    return _songs;
  }
}
