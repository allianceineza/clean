class Task {
  final int? id;
  final String title;
  final String description;
  final String category; // 'pickup', 'delivery', 'cleaning', 'maintenance'
  final String status; // 'pending', 'in_progress', 'completed', 'cancelled'
  final int? assignedToUserId;
  final int createdByAdminId;
  final DateTime dueDate;
  final String priority; // 'low', 'medium', 'high'
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    this.assignedToUserId,
    required this.createdByAdminId,
    required this.dueDate,
    required this.priority,
    required this.createdAt,
  });

  // Convert Task to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'assigned_to_user_id': assignedToUserId,
      'created_by_admin_id': createdByAdminId,
      'due_date': dueDate.toIso8601String(),
      'priority': priority,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create Task from Map (database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      status: map['status'],
      assignedToUserId: map['assigned_to_user_id'],
      createdByAdminId: map['created_by_admin_id'],
      dueDate: DateTime.parse(map['due_date']),
      priority: map['priority'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  // Create a copy with modifications
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? status,
    int? assignedToUserId,
    int? createdByAdminId,
    DateTime? dueDate,
    String? priority,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      assignedToUserId: assignedToUserId ?? this.assignedToUserId,
      createdByAdminId: createdByAdminId ?? this.createdByAdminId,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
