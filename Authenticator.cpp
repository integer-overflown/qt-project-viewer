#include <Authenticator.hpp>
#include <QNetworkAccessManager>
#include <QHttpPart>
#include <QJsonDocument>
#include <QJsonObject>
#include <QPointer>
#include <QMetaEnum>

static inline bool is_ignorable_ssl_error(const QSslError& e);

void Authenticator::verify(QString login, QString password)
{
    QPointer<QNetworkAccessManager> manager = new QNetworkAccessManager;
    QNetworkRequest request;
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setUrl(address);

    QJsonDocument document(QJsonObject{
        {"login", login},
        {"password", password}
    });

    QNetworkReply* reply = manager->post(request, document.toJson(QJsonDocument::Compact));

    // handle successful attempt
    QObject::connect(reply, &QNetworkReply::finished, this, [this, reply]{ // TODO: maybe disconnect earlier?
        QJsonParseError* error_ptr = nullptr;
        auto json = QJsonDocument::fromJson(reply->readAll(), error_ptr);
        if (json.isNull() && error_ptr)
            emit error(error_ptr->errorString());
        else if (auto value = json["token"]; value == QJsonValue::Undefined)
            emit error("No token value in response");
        else
            emit submitted(value.toString());
        reply->deleteLater();
    });

    // handle network errors
    QObject::connect(reply, &QNetworkReply::errorOccurred, this, [this](QNetworkReply::NetworkError error){
        auto enumerator = QMetaEnum::fromType<QNetworkReply::NetworkError>();
        emit this->error(enumerator.valueToKey(error));
    });

    // ignore allowed ssl errors
    QObject::connect(reply, &QNetworkReply::sslErrors, this, [reply](const QList<QSslError> &errorList) {
       if (std::all_of(errorList.constBegin(), errorList.constEnd(), is_ignorable_ssl_error))
           reply->ignoreSslErrors(errorList);
    });
}

bool is_ignorable_ssl_error(const QSslError& e)
{
    int c = e.error();
    return c == QSslError::CertificateUntrusted || c == QSslError::SelfSignedCertificate;
}

