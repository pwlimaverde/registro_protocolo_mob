enum Routes {
  initial(caminho: "/"),
  // home,
  splash(caminho: "/splash");

  final String caminho;
  const Routes({required this.caminho});
}
