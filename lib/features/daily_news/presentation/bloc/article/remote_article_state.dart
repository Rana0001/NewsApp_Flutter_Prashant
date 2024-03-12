part of 'remote_article_bloc.dart';

sealed class RemoteArticleState extends Equatable {
  final List<AritlcesEntity>? articlesEntity;
  final DioException? error;
  const RemoteArticleState({this.articlesEntity, this.error});

  @override
  List<Object> get props => [articlesEntity!, error!];
}

final class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

final class RemoteArticleSuccess extends RemoteArticleState {
  const RemoteArticleSuccess({required List<AritlcesEntity> articlesEntity})
      : super(articlesEntity: articlesEntity);
}

final class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError({required DioException error}) : super(error: error);
}

