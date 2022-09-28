enum Routes {
  initial(caminho: "/"),
  // home,
  splash(caminho: "/splash"),
  uploadcsv(caminho: "/uploadcsv");

  final String caminho;
  const Routes({required this.caminho});
}
