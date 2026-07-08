/// Application-wide enumerations.

/// Property types available on the platform.
enum PropertyType {
  house,
  apartment,
  land,
  commercial,
  office,
  warehouse,
  villa,
  duplex,
  studio,
}

/// Property listing purpose.
enum ListingType { sale, rent, lease, shortlet, investment }

/// Escrow transaction lifecycle states.
enum EscrowStatus {
  pending,
  fundsHeld,
  inspection,
  verification,
  approved,
  released,
  refunded,
  disputed,
}

/// Agent verification status.
enum VerificationStatus { unverified, pending, verified, rejected }

/// Document types for agent KYC.
enum DocumentType { passport, nationalId, driverLicense, residencePermit }

/// Property verification document types.
enum PropertyDocumentType { ownershipDoc, surveyDoc, governmentRecord }

/// Subscription tiers for agents.
enum SubscriptionTier { free, basic, professional, enterprise }

/// Order / transaction status.
enum OrderStatus { pending, processing, completed, cancelled, disputed }

/// Message types in chat.
enum MessageType { text, image, document }

/// Notification type.
enum NotificationType { push, inApp }
