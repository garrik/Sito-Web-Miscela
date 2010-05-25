using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Xml.Serialization;
using System.Xml.Xsl;

namespace Miscela
{
    /// <summary>
    /// Application login tools
    /// </summary>
    public class LoginTools
    {
		/// <summary>
		/// The username.
		/// </summary>
        public const string Userid = "UserID";

		/// <summary>
		/// A logout flag.
		/// </summary>
		public const string Logout = "Logout";
    }

    /// <summary>
    /// Repository file names.
    /// </summary>
    public class FN {
        public const string ARTICLES = "/App_Data/articles.xml";
        public const string FORM = "/App_Data/admin.xml";
        public const string ADMIN_XSLT = "Admin.xsl";
        public const string PREVIEW_XSLT = "Preview.xsl";
        public const string MAIL = "/App_Data/email.xml";
        public const string HEADLINES_XSLT = "Headlines.xsl";
    }

    /// <summary>
    /// XML serialization class for newsletter subscriptions.
    /// </summary>
    [XmlRoot]
    public class EmailWarehouse
    {
        private ArrayList subscriptionsList;

        public EmailWarehouse()
        {
            subscriptionsList = new ArrayList();
        }

        [XmlElement]
        public Subscription[] Subscriptions
        {
            get
            {
                Subscription[] subscriptions = new Subscription[subscriptionsList.Count];
                subscriptionsList.CopyTo(subscriptions);
                return subscriptions;
            }
            set
            {
                if (value == null) return;
                Subscription[] subscriptions = (Subscription[])value;
                subscriptionsList.Clear();
                foreach (Subscription subscription in subscriptions)
                    subscriptionsList.Add(subscription);
            }
        }

        public int AddSubscription(Subscription subscription)
        {
            return subscriptionsList.Add(subscription);
        }
    }

    public class Subscription
    {
        [XmlAttribute]
        public int category;
        [XmlAttribute]
        public string date;
        [XmlElement]
        public string email;
    }

    /// <summary>
    /// XML serialization class for articles.
    /// </summary>
    [XmlRoot]
    public class ArticlesWarehouse
    {
        private ArrayList articlesList;

        public ArticlesWarehouse()
        {
            articlesList = new ArrayList();
        }

        [XmlArray]
        [XmlArrayItem]
        public Article[] Articles
        {
            get
            {
                Article[] articles = new Article[articlesList.Count];
                articlesList.CopyTo(articles);
                return articles;
            }
            set
            {
                if (value == null) return;
                Article[] articles = (Article[])value;
                articlesList.Clear();
                foreach (Article article in articles)
                    articlesList.Add(article);
            }
        }

        public int AddArticle(Article article)
        {
            return articlesList.Add(article);
        }
        public void RemoveArticle(string id)
        {
            articlesList.Remove(FindArticle(id));
        }
        public Article FindArticle(string id)
        {
            foreach (Article article in articlesList)
            {
                if (article.id == id)
                    return article;
            }
            return null;
        }
    }

    public class Article
    {
        //[XmlAttribute]
        //public int category;
        [XmlAttribute]
        public string author;
        [XmlAttribute]
        public string date;
        [XmlAttribute]
        public bool draft;
        [XmlAttribute]
        public string id;
        [XmlElement]
        public string title;
        [XmlElement]
        public string content;
    }
}
