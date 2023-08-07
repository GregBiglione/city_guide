class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMilliseconds - expirationTime < cacheTime;

    return isCacheValid;
  }
}