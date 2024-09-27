
class WatchlistData {
  static final List<String> watchList = [];


  static void add(String item) {
    if (!watchList.contains(item)) {
      watchList.add(item);
    }
  }

  static void remove(String item) {
    watchList.remove(item);
  }

  static List<String> get watchlist => List.unmodifiable(watchList);
}
