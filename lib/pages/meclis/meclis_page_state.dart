import 'package:flutter/foundation.dart';
import '../../client/models/meclis_model.dart';
import '../../client/models/meclis_parti_model.dart';
import '../../client/services/meclis_parti_service.dart';
import '../../client/services/meclis_service.dart';

/// State management for the Meclis page
class MeclisPageState extends ChangeNotifier {
  /// Service for fetching council member data
  final MeclisService service;

  /// Service for fetching political party data
  final MeclisPartiService partyService;

  /// List of all council members
  List<MeclisModel> _allMembers = [];

  /// List of political parties
  List<MeclisPartiModel> _parties = [];

  /// List of displayed council members (after filtering)
  List<MeclisModel> _displayedMembers = [];

  /// Map of members grouped by party
  Map<String, List<MeclisModel>> _groupedMembers = {};

  /// Currently selected party for filtering
  String? _selectedParty;

  /// Whether to group members by party
  bool _isGroupedByParty = false;

  /// Loading state
  bool _isLoading = false;

  /// Error information if fetching fails
  String? _error;

  /// Creates a new [MeclisPageState] with the needed services
  MeclisPageState({
    required this.service,
    required this.partyService,
  });

  /// Getter for all council members
  List<MeclisModel> get allMembers => _allMembers;

  /// Getter for displayed council members
  List<MeclisModel> get displayedMembers => _displayedMembers;

  /// Getter for political parties
  List<MeclisPartiModel> get parties => _parties;

  /// Getter for grouped members
  Map<String, List<MeclisModel>> get groupedMembers => _groupedMembers;

  /// Getter for loading state
  bool get isLoading => _isLoading;

  /// Getter for error information
  String? get error => _error;

  /// Getter for selected party
  String? get selectedParty => _selectedParty;

  /// Getter for grouping state
  bool get isGroupedByParty => _isGroupedByParty;

  /// Loads council members and parties from the services
  Future<void> loadMeclis() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Load parties first
      _parties = await partyService.getMeclisPartiler();

      // Load all members
      _allMembers = await service.getAllMeclisUyeleri();

      // Initialize displayed members with all members
      _displayedMembers = List.from(_allMembers);

      // Create grouped map
      _updateGroupedMembers();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filters members by party
  void filterByParty(String party) {
    _selectedParty = party;
    _applyFilters();
  }

  /// Clears party filter
  void clearPartyFilter() {
    _selectedParty = null;
    _applyFilters();
  }

  /// Toggles grouping by party
  void toggleGroupByParty() {
    _isGroupedByParty = !_isGroupedByParty;
    _updateGroupedMembers();
    notifyListeners();
  }

  /// Applies current filters (party)
  void _applyFilters() {
    _displayedMembers = _allMembers.where((member) {
      final matchesParty =
          _selectedParty == null || member.party == _selectedParty;

      return matchesParty;
    }).toList();

    _updateGroupedMembers();
    notifyListeners();
  }

  /// Updates the grouped members map
  void _updateGroupedMembers() {
    // Group displayed members by party
    _groupedMembers = {};

    for (final member in _displayedMembers) {
      final party = member.party ?? 'Diğer';
      if (!_groupedMembers.containsKey(party)) {
        _groupedMembers[party] = [];
      }
      _groupedMembers[party]!.add(member);
    }
  }
}
