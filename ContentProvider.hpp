#ifndef QMLTEST_CONTENT_PROVIDER_H
#define QMLTEST_CONTENT_PROVIDER_H
#include <QString>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QPointer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <private/Credentials.hpp>

template<typename ObjectType>
class ContentProvider
{
protected:
    using Data = QVector<ObjectType>;

    template<typename... Chunk>
    ContentProvider(const QString& type, const QString& token, Chunk... chunks);

    virtual ObjectType handleNextObject(const QJsonObject&) const = 0;
    virtual void ready(Data) = 0;
};

template<typename ObjectType>
template<typename... Chunk>
ContentProvider<ObjectType>::ContentProvider(const QString& type, const QString& token, Chunk... chunks)
{
    QPointer manager { new QNetworkAccessManager };
    QNetworkRequest request(QUrl { api::path(chunks...) });
    request.setRawHeader("Authorization", token.toUtf8());

    auto reply = manager->get(request);
    QObject::connect(reply, &QNetworkReply::finished, [=]{
        if (reply->error() != QNetworkReply::NoError)
            return;

        Data objects;
        auto doc = QJsonDocument::fromJson(reply->readAll());
        auto rawArray = doc[type];
        if (rawArray.isUndefined())
            qWarning() << "No value corresponds to '" << type << "' in response";

        auto array = rawArray.toArray();
        for (const auto& entry : array)
            objects.append(handleNextObject(entry.toObject()));

        ready(std::move(objects));
        manager->deleteLater();
    });
    QObject::connect(reply, &QNetworkReply::errorOccurred, [](QNetworkReply::NetworkError code){
        qCritical() << code;
    });
    QObject::connect(reply, &QNetworkReply::sslErrors, [reply](const QList<QSslError>& list) { // TODO: duplicate code
        reply->ignoreSslErrors(list);
    });
}

#endif // QMLTEST_CONTENT_PROVIDER_H
