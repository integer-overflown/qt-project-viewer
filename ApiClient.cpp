#include <ApiClient.hpp>
#include <QNetworkReply>

static inline bool is_ignorable_ssl_error(const QSslError& e);

ApiClient::ApiClient(const QString& path)
    : manager(new QNetworkAccessManager), request(QUrl { path })
{
    const auto sslErrorOccured = [](QNetworkReply* reply, const QList<QSslError>& errorList)
    {
        if (std::all_of(errorList.constBegin(), errorList.constEnd(), is_ignorable_ssl_error))
            reply->ignoreSslErrors(errorList);
    };
    QObject::connect(manager.data(), &QNetworkAccessManager::sslErrors, sslErrorOccured);
}

bool is_ignorable_ssl_error(const QSslError& e)
{
    int c = e.error();
    return c == QSslError::CertificateUntrusted || c == QSslError::SelfSignedCertificate;
}
