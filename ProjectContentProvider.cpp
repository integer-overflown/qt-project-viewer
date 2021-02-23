#include <ProjectContentProvider.hpp>
#include <QPointer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <private/Credentials.hpp>

ProjectContentProvider::ProjectContentProvider(const QString& token, QObject* parent)
: QObject(parent)
{
    QPointer manager { new QNetworkAccessManager };
    QNetworkRequest request;
    request.setRawHeader("Authorization", token.toUtf8());
    request.setUrl(QUrl { api::path(api::projects) });

    auto reply = manager->get(request);
    QObject::connect(reply, &QNetworkReply::finished, this, [=]{
        if (reply->error() != QNetworkReply::NoError)
            return;
        QList<Project> projects;
        auto doc = QJsonDocument::fromJson(reply->readAll());
        auto array = doc["projects"].toArray();
        for (const auto& project : array) {
            const auto o = project.toObject();
            projects.append(Project { o["id"].toInt(), o["name"].toString(), QUrl { o["icon"].toString() } });
        }
        emit success(std::move(projects));
        manager->deleteLater();
    });
    QObject::connect(reply, &QNetworkReply::errorOccurred, [](QNetworkReply::NetworkError error){
        qCritical() << error;
    });
    QObject::connect(reply, &QNetworkReply::sslErrors, this, [reply](auto list) { // TODO: duplicate code
        reply->ignoreSslErrors(list);
    });
}
