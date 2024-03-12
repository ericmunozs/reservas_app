abstract class ClubService {
  Future<void> getAll();
  Future<void> get(String id);
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
}
