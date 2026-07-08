/// Shared Freezed models used across features.
///
/// These are the platform-wide data models:
///
/// - UserModel (id, email, fullName, phone, avatar, role, createdAt)
/// - PropertyModel (id, agentId, title, description, type, listingType, price,
///   currency, location, bedrooms, bathrooms, area, amenities, status, createdAt)
/// - PropertyMediaModel (id, propertyId, url, type, order)
/// - LocationModel (country, state, city, address, latitude, longitude)
/// - MessageModel (id, conversationId, senderId, content, type, createdAt)
/// - ConversationModel (id, participants, lastMessage, updatedAt)
/// - OrderModel (id, propertyId, buyerId, agentId, status, amount, createdAt)
/// - EscrowModel (id, orderId, amount, status, createdAt, releasedAt)
/// - WalletModel (id, agentId, balance, currency, updatedAt)
/// - ReviewModel (id, agentId, buyerId, rating, comment, createdAt)
/// - VerificationModel (id, userId, documentType, documentUrl, status)
/// - SubscriptionModel (id, agentId, tier, expiresAt, isActive)
/// - NotificationModel (id, userId, title, body, type, isRead, createdAt)
/// - OfferModel (id, propertyId, buyerId, amount, message, status, createdAt)
/// - WithdrawalModel (id, agentId, amount, status, bankDetails, createdAt)

// TODO: Implement with @freezed annotation and json_serializable
