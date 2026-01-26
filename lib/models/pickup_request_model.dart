class PickupRequest {
  final String id;
  final String userId;
  final String itemDescription;
  final String pickupAddress;
  final DateTime requestedDateTime;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? completedAt;

  PickupRequest({
    required this.id,
    required this.userId,
    required this.itemDescription,
    required this.pickupAddress,
    required this.requestedDateTime,
    required this.status,
    this.notes,
    required this.createdAt,
    this.completedAt,
  });

  /// Create a PickupRequest from JSON
  factory PickupRequest.fromJson(Map<String, dynamic> json) {
    return PickupRequest(
      id: json['id'] as String,
      userId: json['userId'] as String,
      itemDescription: json['itemDescription'] as String,
      pickupAddress: json['pickupAddress'] as String,
      requestedDateTime: DateTime.parse(json['requestedDateTime'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  /// Convert PickupRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'itemDescription': itemDescription,
      'pickupAddress': pickupAddress,
      'requestedDateTime': requestedDateTime.toIso8601String(),
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  /// Create a copy of PickupRequest with optional field overrides
  PickupRequest copyWith({
    String? id,
    String? userId,
    String? itemDescription,
    String? pickupAddress,
    DateTime? requestedDateTime,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return PickupRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      itemDescription: itemDescription ?? this.itemDescription,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      requestedDateTime: requestedDateTime ?? this.requestedDateTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'PickupRequest(id: $id, userId: $userId, itemDescription: $itemDescription, '
        'pickupAddress: $pickupAddress, requestedDateTime: $requestedDateTime, '
        'status: $status, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickupRequest &&
        other.id == id &&
        other.userId == userId &&
        other.itemDescription == itemDescription &&
        other.pickupAddress == pickupAddress &&
        other.requestedDateTime == requestedDateTime &&
        other.status == status &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.completedAt == completedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        itemDescription.hashCode ^
        pickupAddress.hashCode ^
        requestedDateTime.hashCode ^
        status.hashCode ^
        notes.hashCode ^
        createdAt.hashCode ^
        completedAt.hashCode;
  }
}
