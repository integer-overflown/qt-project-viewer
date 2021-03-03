#ifndef QMLTEST_PROJECT_H
#define QMLTEST_PROJECT_H
#include <QString>
#include <QUrl>
#include <QVariant>

struct Project
{
    Q_GADGET
    Q_PROPERTY(int id MEMBER id)
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QUrl icon MEMBER icon)

public:
    static constexpr auto aggregate = "projects";

    Project(const int id, const QString& name, const QUrl& icon)
        : id(id), name(name), icon(icon) {}
private:
    int id;
    QString name;
    QUrl icon;
};

#endif // QMLTEST_PROJECT_H
