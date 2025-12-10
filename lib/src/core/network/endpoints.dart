enum Endpoints {
  products(path: "/products");

  const Endpoints({required this.path});

  final String path;

  String get url => "$_baseUrl/$path";

  String urlWithId({required String id}) => "$url/$id";

  static const String _baseUrl = "https://fakestoreapi.com";
}
