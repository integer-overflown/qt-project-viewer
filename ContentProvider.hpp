#ifndef QMLTEST_CONTENT_PROVIDER_H
#define QMLTEST_CONTENT_PROVIDER_H
#include <QString>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QPointer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <ApiClient.hpp>
#include <private/Credentials.hpp>

template<typename ObjectType>
class ContentProvider : public ApiClient
{
protected:
    using Data = QVector<ObjectType>;

    ContentProvider(const QString& path, const QString& token, const QString& type);

    virtual ObjectType handleNextObject(const QJsonObject&) const = 0;
    virtual void ready(Data) = 0;
};

template<typename ObjectType>
ContentProvider<ObjectType>::ContentProvider(const QString& path, const QString& token, const QString& type)
    : ApiClient(path)
{
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
    QObject::connect(reply, &QNetworkReply::errorOccurred, [path](QNetworkReply::NetworkError code){
        qCritical() << "Error when fetching " << path << ":" << code;
    });
}

#endif // QMLTEST_CONTENT_PROVIDER_H
