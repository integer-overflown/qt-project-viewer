#include <Authenticator.hpp>
#include <QNetworkAccessManager>
#include <QHttpPart>
#include <QJsonDocument>
#include <QJsonObject>
#include <QPointer>
#include <QMetaEnum>
#include <private/Credentials.hpp>

Authenticator::Authenticator(QObject* parent)
    : QObject(parent), ApiClient(api::path(api::login))
{
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
}

void Authenticator::verify(QString login, QString password)
{
    QJsonDocument document(QJsonObject{
        {"login", login},
        {"password", password}
    });

    QNetworkReply* reply = manager->post(request, document.toJson(QJsonDocument::Compact));

    // handle successful attempt
    QObject::connect(reply, &QNetworkReply::finished, this, [this, reply] {
        if (reply->error() != QNetworkReply::NoError) return;

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
    QObject::connect(reply, &QNetworkReply::errorOccurred, this, [this](QNetworkReply::NetworkError error) {
        if (error == QNetworkReply::AuthenticationRequiredError)
            emit rejected();
        else {
            auto enumerator = QMetaEnum::fromType<QNetworkReply::NetworkError>();
            emit this->error(enumerator.valueToKey(error));
        }
    });
}
