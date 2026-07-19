import ArticleActions from './ArticleActions';
import { Link } from 'react-router-dom';
import React from 'react';

const ArticleMeta = props => {
  const article = props.article;
  return (
    <div className="article-meta">
      <Link to={`/@${article.author.username}`}>
        <img
          src={article.author.image || `https://ui-avatars.com/api/?name=${article.author.username}&size=64&background=random`}
          style={{ width: '32px', height: '32px', borderRadius: '50%', objectFit: 'cover' }}
          alt={article.author.username}
        />
      </Link>

      <div className="info">
        <Link to={`/@${article.author.username}`} className="author">
          {article.author.username}
        </Link>
        <span className="date">
          {new Date(article.createdAt).toDateString()}
        </span>
      </div>

      <ArticleActions canModify={props.canModify} article={article} />
    </div>
  );
};

export default ArticleMeta;
