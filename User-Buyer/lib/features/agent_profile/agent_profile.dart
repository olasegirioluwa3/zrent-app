/// Agent Profile Feature Module — Buyer App
///
/// Presentation: agent profile screen, reviews list, contact details, active listings
/// Application: GetAgentProfileUseCase, GetAgentReviewsUseCase
/// Domain: AgentProfileRepository interface
/// Data: SupabaseAgentProfileDataSource, AgentProfileRepositoryImpl

export 'domain/entities/agent_review.dart';
export 'presentation/providers/agent_reviews_provider.dart';
export 'presentation/screens/agent_profile_screen.dart';
export 'presentation/widgets/add_review_modal.dart';
export 'presentation/widgets/reviews_section.dart';
export 'presentation/widgets/agent_stats.dart';
