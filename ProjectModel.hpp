#ifndef QMLTEST_PROJECT_MODEL_H
#define QMLTEST_PROJECT_MODEL_H
#include <QAbstractListModel>
#include <QtQml>
#include <Project.hpp>
#include <ProjectContentProvider.hpp>

class ProjectModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString token WRITE setToken MEMBER _token NOTIFY tokenChanged)
    QML_ELEMENT
public:
    using Data = ProjectContentProvider::Data;
    enum Roles {
        DataRole = Qt::UserRole + 1
    };
    int rowCount(const QModelIndex&) const override;
    QVariant data(const QModelIndex&, int) const override;
    QHash<int, QByteArray> roleNames() const override;
public slots:
    void setToken(const QString&);
signals:
    void tokenChanged(const QString&);
private:
    QList<Project> modelData;
    QString _token;
};

#endif // QMLTEST_PROJECT_MODEL_H
