class Utils{

  static String getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60) +
        (duration.inHours.remainder(24) * 60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

}