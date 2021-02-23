#ifndef QMLTEST_PROJECT_CONTENT_PROVIDER_H
#define QMLTEST_PROJECT_CONTENT_PROVIDER_H
#include <QObject>
#include <QString>
#include <Project.hpp>

class ProjectContentProvider : public QObject
{
    Q_OBJECT
public:
    ProjectContentProvider(const QString& token, QObject* parent = nullptr);
signals:
    void success(QList<Project>);
};

#endif // QMLTEST_PROJECT_CONTENT_PROVIDER_H
