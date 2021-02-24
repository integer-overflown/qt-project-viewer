#ifndef QMLTEST_PROJECT_CONTENT_PROVIDER_H
#define QMLTEST_PROJECT_CONTENT_PROVIDER_H
#include <QObject>
#include <QString>
#include <Project.hpp>
#include <ContentProvider.hpp>

class ProjectContentProvider : public QObject, private ContentProvider<Project>
{
    Q_OBJECT
public:
    using Data = ContentProvider<Project>::Data;
    ProjectContentProvider(const QString& token, QObject* parent = nullptr);
signals:
    void success(Data);
private:
    Project handleNextObject(const QJsonObject&) const override;
    void ready(Data) override;
};

#endif // QMLTEST_PROJECT_CONTENT_PROVIDER_H
